using System;
using System.Collections.Generic;
using UniversalDashboard.Models;

namespace UniversalDashboard.Interfaces
{
    public interface IDashboardService 
    {
        void SetDashboard(Dashboard dashboard);
        void SetRestEndpoints(Endpoint[] endpoints);
        Dashboard Dashboard { get; }
        DashboardOptions DashboardOptions { get; }
        IUDRunspaceFactory RunspaceFactory { get; }
        Dictionary<Guid, string> ElementScripts { get; }
        string UpdateToken { get; set; }
        string ReloadToken { get; set; }
        DateTime StartTime { get; }
        IEndpointService EndpointService { get; }
    }
}
