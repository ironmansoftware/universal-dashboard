using System;
using System.Linq;
using System.Management.Automation;
using UniversalDashboard.Models;
using Newtonsoft.Json;
using NLog;
using System.Security.Cryptography.X509Certificates;
using System.Security;
using System.IO;
using System.Reflection;
using System.Net;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsLifecycle.Start, "UDDashboard", DefaultParameterSetName = "Dashboard")]
    public class StartDashboardCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(StartDashboardCommand));

		[Parameter(ParameterSetName = "Content")]
		public ScriptBlock Content { get; set; }

		[Parameter(ParameterSetName = "Dashboard")]
		public Dashboard Dashboard { get; set; }

		[Parameter(ParameterSetName = "DashboardFile")]
		public string FilePath { get; set; }

		[Parameter()]
		public Endpoint[] Endpoint { get; set; }

		[Parameter]
		public string Name { get; set; }

		[Parameter]
	    public int Port { get; set; } = 80;
		
		[Parameter]
	    public int? HttpsPort { get; set; }

		[Parameter]
		public SwitchParameter Wait { get; set; }

		[Parameter]
		public SwitchParameter AutoReload { get; set; }

		[Parameter()]
		public X509Certificate2 Certificate { get; set; }

		[Parameter()]
		public string CertificateFile { get; set; }

		[Parameter()]
		public SecureString CertificateFilePassword { get; set; }

		[Parameter]
		public string UpdateToken { get; set; }

		[Parameter]
		public PublishedFolder[] PublishedFolder { get; set; }

		[Parameter()]
		public SwitchParameter Force { get; set; }
		[Parameter()]
		public IPAddress ListenAddress { get; set; } = IPAddress.Any;

		[Parameter()]
		public SwitchParameter DisableTelemetry { get; set; }
		
        protected override void EndProcessing()
	    {
            var assemblyBasePath = Path.GetDirectoryName(this.GetType().GetTypeInfo().Assembly.Location);
            var tempPath = Path.Combine(assemblyBasePath, "..", Constants.ModuleManifest);

			var enterprisePath = Path.Combine(assemblyBasePath, "..", "..", "UniversalDashboard.psd1");
			if (File.Exists(enterprisePath))
			{
				tempPath = enterprisePath;
			}


			if (Force) {
				var existingServer = Server.Servers.FirstOrDefault(m => m.Port == Port || m.Name == m.Name);
				if (existingServer != null) {
					existingServer.Stop();
					Server.Servers.Remove(existingServer);
				}
			}

            // Cache dashboard
            if (Content == null && Dashboard == null && FilePath == null && File.Exists(Constants.CachedDashboardPath)) {
				using(var powershell = PowerShell.Create()) {
                    powershell.AddStatement().AddCommand("Import-Module").AddParameter("Name", tempPath);
                    powershell.AddStatement().AddScript($". '{Constants.CachedDashboardPath}'");
					Dashboard = powershell.Invoke().FirstOrDefault()?.BaseObject as Dashboard;
				}

				if (Dashboard == null) {
					throw new Exception($"The file {Constants.CachedDashboardPath} did not return a valid dashboard");
				}
			}

			// Dashboard from specified file
			if (ParameterSetName == "DashboardFile")
		    {
				using(var powershell = PowerShell.Create()) {
                    powershell.AddStatement().AddCommand("Import-Module").AddParameter("Name", tempPath);
                    powershell.AddStatement().AddScript($". '{FilePath}'");
					Dashboard = powershell.Invoke().FirstOrDefault()?.BaseObject as Dashboard;
				}

				if (Dashboard == null) {
					throw new Exception($"The file {FilePath} did not return a valid dashboard");
				}
			}

			// Dashboard from script block
		    if (ParameterSetName == "Content")
		    {
				Dashboard = Content.Invoke().FirstOrDefault()?.BaseObject as Dashboard;
			}

            // Demo dashboard
            if (Content == null && Dashboard == null && FilePath == null && !File.Exists(Constants.CachedDashboardPath)) {
				using(var powershell = PowerShell.Create()) {
                    powershell.AddStatement().AddCommand("Import-Module").AddParameter("Name", tempPath);
                    powershell.AddStatement().AddCommand("Import-Module").AddParameter("Name", Constants.DemoDashboardPath);
					powershell.AddStatement().AddCommand("New-DemoDashboard");
					Dashboard = powershell.Invoke().FirstOrDefault()?.BaseObject as Dashboard;
				}

				if (Dashboard == null) {
					throw new Exception($"The file {Constants.DemoDashboardPath} did not return a valid dashboard");
				}
			}
			
			// Dashboard from parameter
		    if (Dashboard == null)
		    {
				Log.Info("Invalid dashboard.");
			    throw new Exception("Invalid dashboard.");
		    }

            Log.Info($"{Name} - {MyInvocation.ScriptName} - {AutoReload}");
			Log.Debug(JsonConvert.SerializeObject(Dashboard));

			if (string.IsNullOrEmpty(MyInvocation.ScriptName) && AutoReload)
			{
				WriteWarning("AutoReload does not work on the command line. You must save your file as a script.");
			}

			var server = new Server(Name, base.MyInvocation.ScriptName, AutoReload, Host, Port, Certificate != null || CertificateFile != null);

			var options = new DashboardOptions();
			options.Dashboard = Dashboard;
			options.StaticEndpoints = Endpoint;
			options.Certificate = Certificate;
			options.Port = Port;
			options.HttpsPort = HttpsPort.HasValue ? HttpsPort.Value : Port;
			options.Wait = Wait;
			options.CertificateFile = CertificateFile;
			options.Password = CertificateFilePassword;
			options.EndpointInitialSessionState = Dashboard.EndpointInitialSessionState;
			options.UpdateToken = UpdateToken;
			options.PublishedFolders = PublishedFolder;
			options.ListenAddress = ListenAddress;
			options.DisableTelemetry = DisableTelemetry;

            try
		    {
			    server.Start(options);
		    }
		    catch (AggregateException ex)
		    {
				Log.Error("Failed to start dashboard.", ex);
			    throw ex.GetBaseException();
		    }

		    WriteObject(server);
	    }


	}
}
