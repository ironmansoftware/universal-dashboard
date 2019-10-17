using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using UniversalDashboard.Models;

namespace UniversalDashboard.Services
{
    public interface ISessionManager
    {
        void StartSession(string id);
        void EndSession(string id);
        bool SessionExists(string id);
        SessionState GetSession(string id);
        ConcurrentDictionary<string, SessionState> Sessions { get; }
        void ClearTimedOutSessions(TimeSpan timespan);
    }

    public class SessionManager : ISessionManager
    {
        public ConcurrentDictionary<string, SessionState> Sessions { get; private set; }

        public SessionManager()
        {
            Sessions = new ConcurrentDictionary<string, SessionState>();
        }

        public void StartSession(string id)
        {
            if (Sessions.ContainsKey(id)) 
            {
                var session = Sessions[id];
                session.LastTouched = DateTime.UtcNow;
                session.Connections++;
            }
            else 
            {
                Sessions.TryAdd(id, new SessionState(id));
            }  
        }

        public void EndSession(string id)
        {
            var session = Sessions[id];
            session.LastTouched = DateTime.UtcNow;
            session.Connections--;
        }

        public bool SessionExists(string id)
        {
            return Sessions.ContainsKey(id);
        }

        public SessionState GetSession(string id)
        {
            var session = Sessions[id];
            session.LastTouched = DateTime.UtcNow;
            return session;
        }

        public void ClearTimedOutSessions(TimeSpan timespan)
        {
            var toRemove = new List<string>();
            foreach(var key in Sessions.Keys)
            {
                var session = Sessions[key];
                if (session.LastTouched < DateTime.UtcNow - timespan)
                {
                    toRemove.Add(session.Id);
                }
            }

            toRemove.ForEach(x => {
                Sessions.TryRemove(x, out SessionState value);
            });
        }
    }   
}