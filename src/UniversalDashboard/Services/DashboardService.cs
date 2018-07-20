using System;
using System.Collections.Generic;
using System.Linq;
using UniversalDashboard.Execution;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;

namespace UniversalDashboard.Services
{
	public class DashboardService : IDashboardService
	{
		public DashboardService(Dashboard dashboard, Endpoint[] restEndpoints, string updateToken, string reloadToken, DashboardOptions dashboardOptions) {
            EndpointService = new EndpointService();
			SetDashboard(dashboard);
            SetRestEndpoints(restEndpoints);
            UpdateToken = updateToken;
			ReloadToken = reloadToken;
            StartTime = DateTime.UtcNow;
            Properties = new Dictionary<string, object>();
            DashboardOptions = dashboardOptions;
        }

		public DashboardService(Endpoint[] restEndpoints, Endpoint endpointInitializationScript, string updateToken, string reloadToken, DashboardOptions dashboardOptions) {
            EndpointService = new EndpointService();
            SetRestEndpoints(restEndpoints);
			SetRunspaceFactory(endpointInitializationScript);
			UpdateToken = updateToken;
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

			SetRunspaceFactory(Dashboard.InitializationScript);
        }

        public void SetRestEndpoints(Endpoint[] endpoints)
        {
            if (endpoints == null) return;

            foreach(var endpoint in endpoints)
            {
                EndpointService.Register(endpoint);
            }
        }

		public void SetRunspaceFactory(Endpoint initializationScript) {
			if (RunspaceFactory != null)
				RunspaceFactory.Dispose();

			RunspaceFactory = new UDRunspaceFactory(this, initializationScript);
		}
    }
}
