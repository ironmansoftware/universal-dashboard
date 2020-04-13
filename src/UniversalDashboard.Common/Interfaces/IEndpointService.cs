using System.Collections.Concurrent;
using System.Collections.Generic;
using UniversalDashboard.Models;

namespace UniversalDashboard.Interfaces
{
    public interface IEndpointService
    {
        AbstractEndpoint Get(string name, string sessionId);
        void Unregister(string name, string sessionId);
        AbstractEndpoint GetByUrl(string url, string method, Dictionary<string, object> matchedVariables);
        IEnumerable<AbstractEndpoint> GetScheduledEndpoints();
        void Register(AbstractEndpoint callback);
        ConcurrentDictionary<string, AbstractEndpoint> Endpoints { get; }
        List<AbstractEndpoint> RestEndpoints { get; }
        ISessionManager SessionManager { get; }
        IScheduledEndpointManager ScheduledEndpointManager { get; set; }
    }
}
