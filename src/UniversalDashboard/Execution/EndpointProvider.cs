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
        private readonly MemoryCache _endpointCache;
        private readonly List<Endpoint> _restEndpoints;
        private readonly List<Endpoint> _scheduledEndpoints;
        private static readonly Logger logger = LogManager.GetLogger("EndpointService");

        private Dictionary<string, object> _sessionLocks = new Dictionary<string, object>();

        private readonly object sessionLock = new object();


        public EndpointService() 
        {
            _endpointCache = new MemoryCache(new MemoryCacheOptions());
            _restEndpoints = new List<Endpoint>();
            _scheduledEndpoints = new List<Endpoint>();
        }

        public MemoryCache EndpointCache => _endpointCache;

        public void StartSession(string sessionId)
        {
            lock(sessionLock)
            {
                if (_sessionLocks.ContainsKey(sessionId)) return;
                _endpointCache.Set(Constants.SessionState + sessionId, new SessionState());
                _sessionLocks.Add(sessionId, new object());
            }   
        }

        public void EndSession(string sessionId)
        {
            lock(sessionLock)
            {
                _endpointCache.Remove(Constants.SessionState + sessionId);
                _sessionLocks.Remove(sessionId);
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
                    _endpointCache.Set(callback.Name, callback);
                }
                else
                {
                    lock(sessionLock)
                    {
                        if (!_sessionLocks.ContainsKey(callback.SessionId))
                        {
                            StartSession(callback.SessionId);
                        }
                    }

                    lock(_sessionLocks[callback.SessionId])
                    {
                        if (_endpointCache.TryGetValue(Constants.SessionState + callback.SessionId, out SessionState sessionState))
                        {
                            sessionState.Endpoints.Add(callback);
                            _endpointCache.Set(Constants.SessionState + callback.SessionId, sessionState);
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

                _restEndpoints.Add(callback);
            }
        }

        public void Unregister(string name, string sessionId)
        {
            logger.Debug($"Unregister() {name} {sessionId}");

            if (sessionId == null)
            {
                if (_endpointCache.TryGetValue(name, out object result))
                {
                    logger.Debug("Endpoint found. Removing endpoint.");
                    _endpointCache.Remove(name);
                }
            }
            else
            {
                if (_endpointCache.TryGetValue(Constants.SessionState + sessionId, out SessionState sessionState))
                {
                    var endpoint = sessionState.Endpoints.FirstOrDefault(m => m.Name?.Equals(name, StringComparison.OrdinalIgnoreCase) == true);
                    if (endpoint != null)
                    {
                        logger.Debug("Session endpoint found. Removing endpoint.");
                        lock(sessionState.SyncRoot)
                        {
                            sessionState.Endpoints.Remove(endpoint);
                            _endpointCache.Set(Constants.SessionState + sessionId, sessionState);
                        }
                    }
                }
            }
        }

        public Endpoint Get(string name, string sessionId)
        {
            logger.Debug($"Get() {name} {sessionId}");

            Endpoint callback;
            if (sessionId != null)
            {
                if (_endpointCache.TryGetValue(Constants.SessionState + sessionId, out SessionState sessionState))
                {
                    var endpoint = sessionState.Endpoints.FirstOrDefault(m => m.Name?.Equals(name, StringComparison.OrdinalIgnoreCase) == true);
                    if (endpoint != null)
                    {
                        logger.Debug("Found session endpoint.");
                        return endpoint;
                    }
                }
            }

            if (_endpointCache.TryGetValue(name, out callback))
            {
                logger.Debug("Found endpoint.");
                return callback;
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
