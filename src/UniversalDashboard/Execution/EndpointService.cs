using UniversalDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using NLog;
using UniversalDashboard.Interfaces;
using System.Text.RegularExpressions;
using System.Collections.Concurrent;
using UniversalDashboard.Services;

namespace UniversalDashboard.Execution
{
    public class EndpointService : IEndpointService
    {
        public List<AbstractEndpoint> RestEndpoints { get; private set; }
        public List<AbstractEndpoint> ScheduledEndpoints { get; private set; }
        private static readonly Logger logger = LogManager.GetLogger("EndpointService");
        public ConcurrentDictionary<string, AbstractEndpoint> Endpoints { get; private set; }
        public ISessionManager SessionManager { get; private set; }
        public IScheduledEndpointManager ScheduledEndpointManager { get; set;  }

      
        public EndpointService() 
        {
            Endpoints = new ConcurrentDictionary<string, AbstractEndpoint>();
            SessionManager = new SessionManager();

            RestEndpoints = new List<AbstractEndpoint>();
            ScheduledEndpoints = new List<AbstractEndpoint>();
        }

        public void Register(AbstractEndpoint callback)
        {
            if (!callback.HasCallback)
            {
                return;
            }

            logger.Debug($"Register() {callback.Name} {callback.Url} {callback.SessionId}");

            if (callback.Schedule != null)
            {
                if (ScheduledEndpointManager == null)
                {
                    ScheduledEndpoints.Add(callback);
                }
                else 
                {
                    ScheduledEndpointManager.SetEndpointSchedule(callback);
                }
            }
            else if (string.IsNullOrEmpty(callback.Url))
            {
                Unregister(callback.Name, callback.SessionId);

                if (callback.SessionId == null)
                {
                    Endpoints.TryAdd(callback.Name, callback);
                }
                else
                {
                    if (!SessionManager.SessionExists(callback.SessionId))
                    {
                        SessionManager.StartSession(callback.SessionId);
                    }

                    if (SessionManager.SessionExists(callback.SessionId))
                    {
                        var session = SessionManager.GetSession(callback.SessionId);
                        session.Endpoints.TryAdd(callback.Name, callback);
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

                var existingEndpoint = RestEndpoints.FirstOrDefault(m => m.Method == callback.Method && m.Url.Equals(callback.Url, StringComparison.OrdinalIgnoreCase));

                if (existingEndpoint != null)
                {
                    RestEndpoints.Remove(existingEndpoint);
                }

                RestEndpoints.Add(callback);
            }
        }

        public void Unregister(string name, string sessionId)
        {
            logger.Debug($"Unregister() {name} {sessionId}");

            ScheduledEndpointManager.RemoveSchedule(name);

            if (sessionId == null)
            {
                if (Endpoints.ContainsKey(name))
                {
                    Endpoints.TryRemove(name, out AbstractEndpoint endpoint);
                    logger.Debug("Endpoint found. Removing endpoint.");
                }
            }
            else
            {
                if (SessionManager.SessionExists(sessionId))
                {
                    var session = SessionManager.GetSession(sessionId);
                    if (session.Endpoints.ContainsKey(name))
                    {
                        logger.Debug("Session endpoint found. Removing endpoint.");
                        session.Endpoints.TryRemove(name, out AbstractEndpoint value);
                    }

                    if (Endpoints.TryGetValue(name, out AbstractEndpoint pageEndpoint) && pageEndpoint.IsPage)
                    {
                        session.Endpoints.Clear();
                    }
                }
            }
        }

        public AbstractEndpoint Get(string name, string sessionId)
        {
            logger.Debug($"Get() {name} {sessionId}");
            if (sessionId != null)
            {
                if (SessionManager.SessionExists(sessionId))
                {
                    var session = SessionManager.GetSession(sessionId);
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

        public AbstractEndpoint GetByUrl(string url, string method, Dictionary<string, object> matchedVariables)
        {
            foreach(var endpoint in RestEndpoints.Where(m => m.Method.Equals(method, StringComparison.OrdinalIgnoreCase)))
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

        public IEnumerable<AbstractEndpoint> GetScheduledEndpoints()
        {
            return ScheduledEndpoints;
        }

        private bool IsMatch(AbstractEndpoint callback, string url, Dictionary<string, object> matchedVariables)
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
