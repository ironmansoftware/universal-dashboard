using NLog;
using UniversalDashboard.Models;
using System;
using System.Management.Automation;
using System.Security;
using System.Security.Cryptography.X509Certificates;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsLifecycle.Start, "UDRestApi")]
    public class StartRestApiCommand : PluggablePSCmdlet
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
		public ScriptBlock EndpointInitializationScript { get; set; }

		[Parameter]
		public SwitchParameter AutoReload { get; set; }

        protected override string CommandKey => "Start-UDRestApi";

        protected override void EndProcessing()
		{
			Log.Info($"{Name} - {MyInvocation.ScriptName} - {AutoReload}");

			if (string.IsNullOrEmpty(MyInvocation.ScriptName) && AutoReload)
			{
				WriteWarning("AutoReload does not work on the command line. You must save your file as a script.");
			}

			var server = new Server(Name, MyInvocation.ScriptName, AutoReload, Host, Port);

            var options = new DashboardOptions();
			options.StaticEndpoints = Endpoint;
			options.Port = Port;
			options.Wait = Wait;
			options.Certificate = Certificate;
			options.CertificateFile = CertificateFile;
			options.Password = CertificateFilePassword;
			options.EndpointInitializationScript = EndpointInitializationScript?.GenerateCallback("IS", SessionState, false);

            AddDynamicParameters(options);
            ValidateModel(options);

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
