using System;
using System.IO;
using System.Management.Automation;
using System.Reflection;
using System.Linq;

namespace UniversalDashboard
{
    class DashboardManager
    {
        private Server _server;

        public void Start()
        {
			var assemblyBasePath = Path.GetDirectoryName(typeof(Program).GetTypeInfo().Assembly.Location);
			var dashboardScript = Path.Combine(assemblyBasePath, "..", "dashboard.ps1");

			using(var powerShell = PowerShell.Create())
			{
                var modulePath = Path.Combine(assemblyBasePath, "..\\UniversalDashboard.psd1");

                powerShell.AddStatement().AddScript("Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process");
                powerShell.AddStatement().AddScript($"Import-Module '{modulePath}'");
                powerShell.AddStatement().AddScript($". '{dashboardScript}'");

				_server = powerShell.Invoke().FirstOrDefault()?.BaseObject as Server;
			}

			if (_server == null || !_server.Running)
			{
				throw new Exception("Failed to start dashboard");
			}
		}

        public void Stop() {
            _server.Stop();
        }
	}
}
