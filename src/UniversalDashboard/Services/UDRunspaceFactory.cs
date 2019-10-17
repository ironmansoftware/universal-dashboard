using System;
using System.IO;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.Reflection;
using NLog;
using UniversalDashboard.Interfaces;

namespace UniversalDashboard.Services
{
    public class RunspaceReference : IRunspaceReference {
		private IUDRunspaceFactory _factory;
        private readonly string _runspaceName;

		public RunspaceReference(IUDRunspaceFactory factory, Runspace runspace) {
			_factory = factory;
			Runspace = runspace;
            _runspaceName = runspace.Name;
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
                    Runspace.Name = _runspaceName;
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

            var assemblyBasePath = Path.GetDirectoryName(this.GetType().GetTypeInfo().Assembly.Location);
            var tempPath = Path.Combine(assemblyBasePath, "..", Constants.ModuleManifest);
			_initialSessionState.Variables.Add(new SessionStateVariableEntry("DashboardService", _dashboardService, "DashboardService", ScopedItemOptions.ReadOnly));
			_initialSessionState.ImportPSModule(new [] {tempPath});

			_runspacePool = new ObjectPool<Runspace>(CreateRunspace);
		}

        public static InitialSessionState GenerateInitialSessionState(System.Management.Automation.SessionState sessionState)
        {
            var initialSessionState = InitialSessionState.CreateDefault2();

            var modulePaths = sessionState.InvokeCommand.InvokeScript("Get-Module").Select(m => m.BaseObject).Cast<PSModuleInfo>().Select(m => m.Path).ToArray();
            initialSessionState.ImportPSModule(modulePaths);

            var commands = sessionState.InvokeCommand.InvokeScript("Get-ChildItem -Path Function:\\").Select(m => m.BaseObject).Cast<FunctionInfo>();
            foreach (var command in commands)
            {
                initialSessionState.Commands.Add(new SessionStateFunctionEntry(command.Name, command.Definition));
            }

            var variables = sessionState.InvokeCommand.InvokeScript("Get-Variable").Select(m => m.BaseObject).Cast<PSVariable>();
            foreach (var variable in variables)
            {
                initialSessionState.Variables.Add(new SessionStateVariableEntry(variable.Name, variable.Value, variable.Description));
            }

            return initialSessionState;
        }

		private Runspace CreateRunspace() {
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

}
