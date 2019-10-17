using System.Collections.Concurrent;
using System.Collections.Generic;
using UniversalDashboard.Models;
using UniversalDashboard.Services;

namespace UniversalDashboard.Interfaces
{
    public interface IEndpointService
    {
        Endpoint Get(string name, string sessionId);
        void Unregister(string name, string sessionId);
        Endpoint GetByUrl(string url, string method, Dictionary<string, object> matchedVariables);
        IEnumerable<Endpoint> GetScheduledEndpoints();
        void Register(Endpoint callback);
        ConcurrentDictionary<string, Endpoint> Endpoints { get; }
        ISessionManager SessionManager { get; }
    }
}
