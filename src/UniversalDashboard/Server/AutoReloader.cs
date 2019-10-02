using System;
using System.Collections.Generic;
using System.IO;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.Reflection;
using System.Management.Automation.Host;
using NLog;
using System.Net;
using System.Linq;

namespace UniversalDashboard
{
    public class AutoReloader {

		private PSHost _host;
		private readonly Logger Log = LogManager.GetLogger(nameof(AutoReloader));

		private Dictionary<string, DashboardInfo> _dashboards = new Dictionary<string, DashboardInfo>();

        public AutoReloader(PSHost host) {
			_host = host;
        }

		public void StartWatchingFile(string fileName, int port, string reloadKey, bool https) {
			var fileInfo = new FileInfo(fileName);

            var fileSystemWatcher = new FileSystemWatcher(fileInfo.DirectoryName);
            fileSystemWatcher.Changed += OnFileChanged;
			fileSystemWatcher.EnableRaisingEvents = true;

			_dashboards.Add(fileInfo.FullName, new DashboardInfo {
				FileSystemWatcher = fileSystemWatcher,
				Port = port,
				ReloadKey = reloadKey,
				Https = https
			});
		}

		public void StopWatchingFile(string fileName) {
            if (string.IsNullOrEmpty(fileName)) return;


			if (_dashboards.ContainsKey(fileName)) {
				_dashboards[fileName].FileSystemWatcher.Dispose();
				_dashboards.Remove(fileName);			
			}
		}

        public void OnFileChanged(object source, FileSystemEventArgs e) {

			Log.Debug($"OnFileChanged - {e.FullPath}"); 

			if (!_dashboards.Any(m => m.Key.Equals(e.FullPath, StringComparison.OrdinalIgnoreCase)))
			{
				return;
			}

			Log.Info("Source file changed. Reloading application.");
						
			try 
			{
				var dashboardInfo = _dashboards.First(m => m.Key.Equals(e.FullPath, StringComparison.OrdinalIgnoreCase)).Value;

				var scheme = dashboardInfo.Https ? "https" : "http";

				var reloadRequest = WebRequest.CreateHttp($"{scheme}://localhost:{dashboardInfo.Port}/api/internal/dashboard/reload");
				reloadRequest.Headers.Add("x-ud-reload-token", dashboardInfo.ReloadKey);
				reloadRequest.Method = "GET";
				var response = reloadRequest.GetResponse();

				var assemblyBasePath = Path.GetDirectoryName(this.GetType().GetTypeInfo().Assembly.Location);

				var tempPath = Path.Combine(assemblyBasePath, "..", Constants.ModuleManifest);
				var initialSessionState = InitialSessionState.CreateDefault();
				initialSessionState.ImportPSModule(new[] { tempPath });

                var server = Server.Servers.FirstOrDefault(m => m.Port == dashboardInfo.Port);
                server.Stop();

				var runspace = RunspaceFactory.CreateRunspace(_host, initialSessionState);
				runspace.Open();

                using (var powerShell = PowerShell.Create()) {
					powerShell.Runspace = runspace;

                    powerShell.AddCommand(e.FullPath);
					powerShell.Invoke();

					if (powerShell.HadErrors)
					{
						foreach(var error in powerShell.Streams.Error)
						{
							Console.WriteLine(error.Exception.Message);
							Log.Warn($"Error while reloading application. {error.Exception.Message}");
						}
					}
				}
			}
			catch (Exception ex) {
				Log.Error(ex.Message);
			}
        }
    }

	public class DashboardInfo {
		public int Port {get;set;}
		public FileSystemWatcher FileSystemWatcher {get;set;}
		public string ReloadKey {get;set;}
		public bool Https { get; set; }
	}


}
