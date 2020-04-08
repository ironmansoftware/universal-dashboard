using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation.Runspaces;
using System.Threading;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using UniversalDashboard.Cmdlets;
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
        public ServiceProvider ServiceProvider { get; set; }
        public IEndpointService EndpointService { get; }
        public Dictionary<string, object> Properties { get; }

        public void SetDashboard(Dashboard dashboard)
        {
			if (dashboard == null) return;

			Dashboard = dashboard;
			SetRunspaceFactory(Dashboard.EndpointInitialSessionState);

            foreach (var endpoint in CmdletExtensions.HostState.EndpointService.Endpoints)
            {
                EndpointService.Register(endpoint.Value);
            }

            foreach (var endpoint in CmdletExtensions.HostState.EndpointService.RestEndpoints)
            {
                EndpointService.Register(endpoint);
            }


            CmdletExtensions.HostState.EndpointService.Endpoints.Clear();
            CmdletExtensions.HostState.EndpointService.RestEndpoints.Clear();

            if (ServiceProvider != null)
            {
                var manager = ServiceProvider.GetServices<IHostedService>().First(m => m is ScheduledEndpointManager) as ScheduledEndpointManager;

                var source = new CancellationTokenSource();
#pragma warning disable CS4014 // Because this call is not awaited, execution of the current method continues before the call is completed
                manager.StartAsync(source.Token);
#pragma warning restore CS4014 // Because this call is not awaited, execution of the current method continues before the call is completed
            }
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
