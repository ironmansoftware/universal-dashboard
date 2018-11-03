using System;
using System.IO;
using System.Management.Automation;
using System.Reflection;
using System.Linq;
using System.Diagnostics;

namespace UniversalDashboard
{
    class DashboardManager
    {
        private Server _server;

        public void Start()
        {
			var assemblyBasePath = Path.GetDirectoryName(typeof(Program).GetTypeInfo().Assembly.Location);
			var dashboardScript = Path.Combine(assemblyBasePath, "..", "dashboard.ps1");

            Log($"Starting Universal Dashboard service. {Environment.NewLine} Dashboard Script: {dashboardScript} {Environment.NewLine} Assembly Base Path: {dashboardScript}", false);

            try 
            {
                using(var powerShell = PowerShell.Create())
                {
                    var modulePath = Path.Combine(assemblyBasePath, "..\\UniversalDashboard.Community.psd1");

                    powerShell.AddStatement().AddScript("Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process");
                    powerShell.AddStatement().AddScript($"Import-Module '{modulePath}'");
                    powerShell.AddStatement().AddScript($". '{dashboardScript}'");

                    _server = powerShell.Invoke().FirstOrDefault()?.BaseObject as Server;

                    if (powerShell.HadErrors) {
                        foreach(var error in powerShell.Streams.Error) {
                            Log($"Error starting dashboard: {Environment.NewLine} {error.ToString()} {Environment.NewLine} {error.ScriptStackTrace}", true);
                        }
                    }
                }
            }
            catch (Exception ex) 
            {
                Log($"Error starting dashboard: {Environment.NewLine} {ex.ToString()}", true);
            }

			if (_server == null || !_server.Running)
			{
				throw new Exception("Failed to start dashboard");
			}
		}

        public void Stop() {
            _server.Stop();
        }

        private void CreateEventSource() {
            #if NET472
            try 
            {
                if (!EventLog.SourceExists("Universal Dashboard"))
                {
                    EventLog.CreateEventSource("Universal Dashboard", "Application");
                }
            }
            catch (Exception ex) 
            {
                Console.WriteLine("Failed to create event source: " + ex.Message);
            }
            #endif
        }

        private void Log(string message, bool error) 
        {
            #if NET472
            try 
            {
                EventLog eventLog = new EventLog();
                eventLog.Source = "Universal Dashboard";
                eventLog.WriteEntry(message, error ? EventLogEntryType.Error : EventLogEntryType.Information);
            }
            catch 
            {

            }
            #endif
            Console.WriteLine(message);
        }
	}
}
