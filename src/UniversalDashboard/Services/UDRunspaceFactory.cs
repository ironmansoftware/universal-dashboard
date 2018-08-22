using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Management.Automation;
using System.Management.Automation.Host;
using System.Management.Automation.Runspaces;
using System.Reflection;
using System.Threading;
using NLog;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;

namespace UniversalDashboard.Services
{
    public class RunspaceReference : IRunspaceReference {
		private IUDRunspaceFactory _factory;

		public RunspaceReference(IUDRunspaceFactory factory, Runspace runspace) {
			_factory = factory;
			Runspace = runspace;
		}

		public Runspace Runspace {get;}

        #region IDisposable Support
        private bool disposedValue = false; // To detect redundant calls

        protected virtual void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
					_factory.ReturnRunspace(Runspace);
                }

                disposedValue = true;
            }
        }

        // This code added to correctly implement the disposable pattern.
        public void Dispose()
        {
            // Do not change this code. Put cleanup code in Dispose(bool disposing) above.
            Dispose(true);
        }
        #endregion
    }

	public class UDRunspaceFactory : IUDRunspaceFactory, IDisposable
	{
		private readonly Logger Log = LogManager.GetLogger("UDRunspaceFactory");
		
		private ObjectPool<Runspace> _runspacePool;
		private InitialSessionState _initialSessionState;
		private IDashboardService _dashboardService;

		public IRunspaceReference GetRunspace() {
			var runspace = _runspacePool.Allocate();

			return new RunspaceReference(this, runspace);
		}

		public void ReturnRunspace(Runspace runspace) {
			_runspacePool.Free(runspace);
		}

		public UDRunspaceFactory(IDashboardService dashboardService, InitialSessionState initialSessionState) {
			_initialSessionState = initialSessionState;
			_dashboardService = dashboardService;

			_runspacePool = new ObjectPool<Runspace>(CreateRunspace);
		}

		private Runspace CreateRunspace() {
			var assemblyBasePath = Path.GetDirectoryName(this.GetType().GetTypeInfo().Assembly.Location);

#if DEBUG 
			var tempPath = Path.Combine(assemblyBasePath, Constants.ModuleManifest);
#else
			var tempPath = Path.Combine(assemblyBasePath, "..", Constants.ModuleManifest);
#endif
			_initialSessionState.Variables.Add(new SessionStateVariableEntry("DashboardService", _dashboardService, "DashboardService", ScopedItemOptions.ReadOnly));
			_initialSessionState.ImportPSModule(new [] {tempPath});
			var runspace = RunspaceFactory.CreateRunspace(new UDHost(), _initialSessionState);
			runspace.Open();
			return runspace;
		}

        #region IDisposable Support
        private bool disposedValue = false; // To detect redundant calls

        protected virtual void Dispose(bool disposing)
        {
            if (!disposedValue)
            {
                if (disposing)
                {
                    ((IDisposable)_runspacePool).Dispose();
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

	public class UDHost : PSHost
	{
		public override string Name => "UDHost";

		public override Version Version => new Version(1, 0);

		public override Guid InstanceId => Guid.NewGuid();

		public override PSHostUserInterface UI => null;

		public override CultureInfo CurrentCulture => CultureInfo.CurrentCulture;

		public override CultureInfo CurrentUICulture => CultureInfo.CurrentUICulture;

		public override void EnterNestedPrompt()
		{
			
		}

		public override void ExitNestedPrompt()
		{
			
		}

		public override void NotifyBeginApplication()
		{
			
		}

		public override void NotifyEndApplication()
		{
			
		}

		public override void SetShouldExit(int exitCode)
		{
			
		}
	}
}
