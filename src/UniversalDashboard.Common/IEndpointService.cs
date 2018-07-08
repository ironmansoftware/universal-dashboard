using System.Collections.Generic;
using UniversalDashboard.Models;

namespace UniversalDashboard.Interfaces
{
    public interface IEndpointService
    {
        Endpoint Get(string name, string sessionId);
        void Unregister(string name, string sessionId);
        Endpoint GetByUrl(string url, string method, Dictionary<string, object> matchedVariables);
        IEnumerable<Endpoint> GetScheduledEndpoints();
        void Register(Endpoint callback);
        void StartSession(string sessionId);
        void EndSession(string sessionId);
    }
}
