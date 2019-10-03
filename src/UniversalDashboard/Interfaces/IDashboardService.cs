using System;
using System.Collections.Generic;
using UniversalDashboard.Models;
using UniversalDashboard.Services;

namespace UniversalDashboard.Interfaces
{
    public interface IDashboardService : IDisposable
    {
        void SetDashboard(Dashboard dashboard);
        void SetRestEndpoints(Endpoint[] endpoints);
        Dashboard Dashboard { get; }
        DashboardOptions DashboardOptions { get; }
        IUDRunspaceFactory RunspaceFactory { get; }
        string UpdateToken { get; set; }
        string ReloadToken { get; set; }
        DateTime StartTime { get; }
        IEndpointService EndpointService { get; }
        Debugger Debugger { get; }
    }
}
