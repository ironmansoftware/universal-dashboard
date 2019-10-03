using NLog;
using UniversalDashboard.Models;
using System;
using System.Management.Automation;
using System.Security;
using System.Security.Cryptography.X509Certificates;
using System.Management.Automation.Runspaces;
using System.Linq;
using UniversalDashboard.Services;
using System.Net;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsLifecycle.Start, "UDRestApi")]
    public class StartRestApiCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(StartDashboardCommand));

		[Parameter()]
		public Endpoint[] Endpoint { get; set; }

		[Parameter]
		public string Name { get; set; }

		[Parameter]
		public int Port { get; set; } = 80;

		[Parameter]
		public SwitchParameter Wait { get; set; }

		[Parameter()]
		public X509Certificate2 Certificate { get; set; }

		[Parameter()]
		public string CertificateFile { get; set; }

		[Parameter()]
		public SecureString CertificateFilePassword { get; set; }

		[Parameter]
		public InitialSessionState EndpointInitialization { get; set; }

		[Parameter]
		public SwitchParameter AutoReload { get; set; }
		[Parameter]
		public PublishedFolder[] PublishedFolder { get; set; }
		
		[Parameter()]
		public SwitchParameter Force { get; set; }

		[Parameter()]
		public IPAddress ListenAddress { get; set; } = IPAddress.Any;


        protected override void EndProcessing()
		{
			Log.Info($"{Name} - {MyInvocation.ScriptName} - {AutoReload}");

			if (EndpointInitialization == null)
			{
				EndpointInitialization = UDRunspaceFactory.GenerateInitialSessionState(SessionState);
			}

			if (string.IsNullOrEmpty(MyInvocation.ScriptName) && AutoReload)
			{
				WriteWarning("AutoReload does not work on the command line. You must save your file as a script.");
			}

			if (Force) {
				var existingServer = Server.Servers.FirstOrDefault(m => m.Port == Port || m.Name == m.Name);
				if (existingServer != null) {
					existingServer.Stop();
					Server.Servers.Remove(existingServer);
				}
			}

			var server = new Server(Name, MyInvocation.ScriptName, AutoReload, Host, Port, Certificate != null || CertificateFile != null);

            var options = new DashboardOptions();
			options.StaticEndpoints = Endpoint;
			options.Port = Port;
			options.Wait = Wait;
			options.Certificate = Certificate;
			options.CertificateFile = CertificateFile;
			options.Password = CertificateFilePassword;
			options.EndpointInitialSessionState = EndpointInitialization;
			options.PublishedFolders = PublishedFolder;
			options.ListenAddress = ListenAddress;

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
