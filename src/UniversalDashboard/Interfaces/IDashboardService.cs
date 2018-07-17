using System;
using System.Collections.Generic;
using UniversalDashboard.Interfaces.Models;
using UniversalDashboard.Models;

namespace UniversalDashboard.Interfaces
{
    public interface IDashboardService : IDynamicModel
    {
        void SetDashboard(Dashboard dashboard);
        void SetRestEndpoints(Endpoint[] endpoints);
        Dashboard Dashboard { get; }
        IUDRunspaceFactory RunspaceFactory { get; }
        Dictionary<int, string> ElementScripts { get; }
        string UpdateToken { get; set; }
        string ReloadToken { get; set; }
        DateTime StartTime { get; }
        IEndpointService EndpointService { get; }
    }
}
