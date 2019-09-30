using Microsoft.Extensions.Caching.Memory;
using UniversalDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using NLog;
using UniversalDashboard.Interfaces;
using System.Text.RegularExpressions;

namespace UniversalDashboard.Execution
{
    public class EndpointService : IEndpointService
    {
        private readonly List<Endpoint> _restEndpoints;
        private readonly List<Endpoint> _scheduledEndpoints;
        private static readonly Logger logger = LogManager.GetLogger("EndpointService");

        private Dictionary<string, object> _sessionLocks = new Dictionary<string, object>();

        private readonly object sessionLock = new object();

        private static IEndpointService _instance;

        public Dictionary<string, Endpoint> Endpoints { get; private set; }
        public Dictionary<string, SessionState> Sessions { get; private set; }

        public static IEndpointService Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new EndpointService();
                }

                return _instance;
            }
        }

        private EndpointService() 
        {
            Endpoints = new Dictionary<string, Endpoint>();
            Sessions = new Dictionary<string, SessionState>();

            _restEndpoints = new List<Endpoint>();
            _scheduledEndpoints = new List<Endpoint>();
        }

        public void StartSession(string sessionId, string connectionId)
        {
            lock(sessionLock)
            {
                if (_sessionLocks.ContainsKey(sessionId)) 
                {
                    lock(_sessionLocks[sessionId])
                    {
                        var session = Sessions[sessionId];
                        session.ConnectionIds.Add(connectionId);
                    }
                }
                else 
                {
                    Sessions.Add(sessionId, new SessionState {
                        ConnectionIds = new List<string> {
                            connectionId
                        }
                    });
                    _sessionLocks.Add(sessionId, new object());
                }
            }   
        }

        public void EndSession(string sessionId, string connectionId)
        {
            lock(sessionLock)
            {
                var session = Sessions[sessionId];
                if (session.ConnectionIds.Count <= 1)
                {
                    Sessions.Remove(sessionId);
                    _sessionLocks.Remove(sessionId);
                }
                else 
                {
                    lock(_sessionLocks[sessionId])
                    {
                        session.ConnectionIds.Remove(connectionId);
                    }
                }
            }
        }

        public void Register(Endpoint callback)
        {
            if (callback.ScriptBlock == null)
            {
                return;
            }

            logger.Debug($"Register() {callback.Name} {callback.Url} {callback.SessionId}");

            if (callback.Schedule != null)
            {
                _scheduledEndpoints.Add(callback);
            }
            else if (string.IsNullOrEmpty(callback.Url))
            {
                Unregister(callback.Name, callback.SessionId);

                if (callback.SessionId == null)
                {
                    Endpoints.Add(callback.Name, callback);
                }
                else
                {
                    lock(sessionLock)
                    {
                        if (!_sessionLocks.ContainsKey(callback.SessionId))
                        {
                            StartSession(callback.SessionId, string.Empty);
                        }
                    }

                    lock(_sessionLocks[callback.SessionId])
                    {
                        if (Sessions.ContainsKey(callback.SessionId))
                        {
                            var session = Sessions[callback.SessionId];
                            session.Endpoints.Add(callback.Name, callback);
                        }
                    }
                }
            }
            else
            {
                if (callback.UrlRegEx == null) {
                    callback.Parts = callback.Url.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries).Select(m => new Part(m, m.StartsWith(":"))).ToArray();

                    if (callback.Parts.GroupBy(m => m.Value).Any(m => m.Count() > 1))
                        throw new Exception("Duplicate variable name in URL.");
                }

                var existingEndpoint = _restEndpoints.FirstOrDefault(m => m.Method == callback.Method && m.Url.Equals(callback.Url, StringComparison.OrdinalIgnoreCase));

                if (existingEndpoint != null)
                {
                    _restEndpoints.Remove(existingEndpoint);
                }

                _restEndpoints.Add(callback);
            }
        }

        public void Unregister(string name, string sessionId)
        {
            logger.Debug($"Unregister() {name} {sessionId}");

            if (sessionId == null)
            {
                if (Endpoints.ContainsKey(name))
                {
                    Endpoints.Remove(name);
                    logger.Debug("Endpoint found. Removing endpoint.");
                }
            }
            else
            {
                if (Sessions.ContainsKey(sessionId))
                {
                    var session = Sessions[sessionId];
                    if (session.Endpoints.ContainsKey(name))
                    {
                        logger.Debug("Session endpoint found. Removing endpoint.");
                        lock(session.SyncRoot)
                        {
                            session.Endpoints.Remove(name);
                        }
                    }
                }
            }
        }

        public Endpoint Get(string name, string sessionId)
        {
            logger.Debug($"Get() {name} {sessionId}");
            if (sessionId != null)
            {
                if (Sessions.ContainsKey(sessionId))
                {
                    var session = Sessions[sessionId];
                    if (session.Endpoints.ContainsKey(name))
                    {
                        logger.Debug("Found session endpoint.");
                        return session.Endpoints[name];
                    }
                }
            }

            if (Endpoints.ContainsKey(name))
            {
                logger.Debug("Found endpoint.");
                return Endpoints[name];
            }

            return null;
        }

        public Endpoint GetByUrl(string url, string method, Dictionary<string, object> matchedVariables)
        {
            foreach(var endpoint in _restEndpoints.Where(m => m.Method.Equals(method, StringComparison.OrdinalIgnoreCase)))
            {
                Dictionary<string, object> variables = new Dictionary<string, object>();

                if (endpoint.UrlRegEx != null) {
                    var matches = endpoint.UrlRegEx.Matches(url);
                    if (matches != null && matches.Count != 0) {
                        foreach(Match match in matches) {
                            for (int i = 1; i < match.Groups.Count; i++)
                            {
                                var group = match.Groups[i];
                                string name = endpoint.UrlRegEx.GroupNameFromNumber(i);

                                if (matchedVariables.ContainsKey(name))
                                {
                                    matchedVariables[name] = group.Value;
                                }
                                else
                                {
                                    matchedVariables.Add(name, group.Value);
                                }
                            }
                        }
                        
                        return endpoint;
                    }
                }

                if (IsMatch(endpoint, url, variables))
                {
                    foreach(var kvp in variables)
                    {
                        if (matchedVariables.ContainsKey(kvp.Key))
                        {
                            matchedVariables[kvp.Key] = kvp.Value;
                        }
                        else
                        {
                            matchedVariables.Add(kvp.Key, kvp.Value);
                        }
                    }
                    return endpoint;
                }
            }

            return null;
        }

        public IEnumerable<Endpoint> GetScheduledEndpoints()
        {
            return _scheduledEndpoints;
        }

        private bool IsMatch(Endpoint callback, string url, Dictionary<string, object> matchedVariables)
        {
            if (callback.Parts == null) return false;

            var urlParts = url.Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries);

            for (var i = 0; i < urlParts.Length; i++)
            {
                if (i >= callback.Parts.Length) return false;

                if (!urlParts[i].Equals(callback.Parts[i].Value, StringComparison.OrdinalIgnoreCase) && !callback.Parts[i].IsVariable) return false;

                if (callback.Parts[i].IsVariable)
                    matchedVariables.Add(callback.Parts[i].Value, urlParts[i]);
            }

            return true;

        }

    }
}
