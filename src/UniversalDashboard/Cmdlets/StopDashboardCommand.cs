using NLog;
using System;
using System.Linq;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsLifecycle.Stop, "UDDashboard")]
    public class StopDashboardCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(StopDashboardCommand));

		[Parameter(Mandatory = true, Position = 1, ParameterSetName = "ByServer", ValueFromPipeline = true)]
		public Server Server { get; set; }

	    [Parameter(Mandatory = true, Position = 1, ParameterSetName = "ByName")]
		public string Name { get; set; }

        [Parameter(Mandatory = true, Position = 1, ParameterSetName = "ByPort")]
        public int Port { get; set; }

        protected override void ProcessRecord()
	    {
		    if (ParameterSetName == "ByServer")
		    {
				Log.Debug("ByServer");
			    Server.Stop();
		    }
		    else if (ParameterSetName == "ByName")
		    {
				Log.Debug($"ByName - {Name}");
				var server =
				    Server.Servers.FirstOrDefault(m => !m.IsRestApi && m.Name.Equals(Name, StringComparison.OrdinalIgnoreCase));

			    if (server == null) throw new Exception($"Server {Name} not found.");

			    server.Stop();
		    }
            else if (ParameterSetName == "ByPort")
            {
                Log.Debug($"ByPort - {Port}");
                var server =
                    Server.Servers.FirstOrDefault(m => !m.IsRestApi && m.Port == Port);

                if (server == null) throw new Exception($"Server on port {Port} not found.");

                server.Stop();
            }
        }
    }
}
