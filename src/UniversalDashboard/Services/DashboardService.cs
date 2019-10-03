using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation.Runspaces;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;

namespace UniversalDashboard.Services
{
	public class DashboardService : IDashboardService
	{
		public DashboardService(DashboardOptions dashboardOptions, string reloadToken) {
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
            Debugger = new Debugger();
        }
        
        public Dashboard Dashboard { get; private set; }
        public DashboardOptions DashboardOptions { get; private set; }
		public Dictionary<Guid, string> ElementScripts {get; private set;}
        public IUDRunspaceFactory RunspaceFactory {get;private set;}
		public string UpdateToken {get;set;}
		public string ReloadToken {get;set;}
        public DateTime StartTime { get; private set; }
        public Debugger Debugger { get; private set; }

        public IEndpointService EndpointService
        {
            get
            {
                return Execution.EndpointService.Instance;
            }
        }

        public Dictionary<string, object> Properties { get; }

        public void SetDashboard(Dashboard dashboard)
        {
			if (dashboard == null) return;

			Dashboard = dashboard;
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

        #region IDisposable Support
        private bool disposedValue = false; 

        protected virtual void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    RunspaceFactory.Dispose();
                }

                disposedValue = true;
            }
        }

        public void Dispose()
        {
            Dispose(true);
        }
        #endregion
    }
}
