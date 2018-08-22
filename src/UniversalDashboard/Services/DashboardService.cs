using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation.Runspaces;
using UniversalDashboard.Execution;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;

namespace UniversalDashboard.Services
{
	public class DashboardService : IDashboardService
	{
		public DashboardService(DashboardOptions dashboardOptions, string reloadToken) {
            EndpointService = new EndpointService();

            if (dashboardOptions.Dashboard != null) 
            {
                SetDashboard(dashboardOptions.Dashboard);
            }

            SetRestEndpoints(dashboardOptions.StaticEndpoints?.ToArray());
            SetRunspaceFactory(dashboardOptions.EndpointInitialSessionState);

            UpdateToken = dashboardOptions.UpdateToken;
			ReloadToken = reloadToken;
            StartTime = DateTime.UtcNow;
            Properties = new Dictionary<string, object>();
            DashboardOptions = dashboardOptions;
        }
        
        public Dashboard Dashboard { get; private set; }
        public DashboardOptions DashboardOptions { get; private set; }
		public Dictionary<int, string> ElementScripts {get; private set;}
        public IUDRunspaceFactory RunspaceFactory {get;private set;}
		public string UpdateToken {get;set;}
		public string ReloadToken {get;set;}
        public DateTime StartTime { get; private set; }

        public IEndpointService EndpointService { get; private set; }

        public Dictionary<string, object> Properties { get; }

        public void SetDashboard(Dashboard dashboard)
        {
			if (dashboard == null) return;

			Dashboard = dashboard;
            var dashboardBuilder = new DashboardBuilder();
			var app = dashboardBuilder.Build(Dashboard);

			ElementScripts = app.ElementScripts;

            foreach (var endpoint in app.Endpoints.ToArray())
            {
                EndpointService.Register(endpoint);
            }

			SetRunspaceFactory(Dashboard.EndpointInitialSessionState);
        }

        public void SetRestEndpoints(Endpoint[] endpoints)
        {
            if (endpoints == null) return;

            foreach(var endpoint in endpoints)
            {
                EndpointService.Register(endpoint);
            }
        }

		public void SetRunspaceFactory(InitialSessionState initialSessionState) {
			if (RunspaceFactory != null)
				RunspaceFactory.Dispose();

			RunspaceFactory = new UDRunspaceFactory(this, initialSessionState);
		}
    }
}
