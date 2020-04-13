using System;
using System.Collections.Concurrent;
using UniversalDashboard.Models;

namespace UniversalDashboard.Interfaces
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
}