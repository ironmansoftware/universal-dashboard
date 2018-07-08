using NLog;
using System;
using System.Linq;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsLifecycle.Stop, "UDRestApi")]
	public class StopRestApiCommand : PSCmdlet
	{
		private readonly Logger Log = LogManager.GetLogger(nameof(StopRestApiCommand));

		[Parameter(Mandatory = true, Position = 1, ParameterSetName = "ByServer", ValueFromPipeline = true)]
		public Server Server { get; set; }

		[Parameter(Mandatory = true, Position = 1, ParameterSetName = "ByName")]
		public string Name { get; set; }

		protected override void ProcessRecord()
		{
			if (ParameterSetName == "ByServer")
			{
				Log.Debug("ByServer");
				Server.Stop();
			}
			else
			{
				Log.Debug($"ByName - {Name}");
				var server =
					Server.Servers.FirstOrDefault(m => m.IsRestApi && m.Name.Equals(Name, StringComparison.OrdinalIgnoreCase));

				if (server == null) throw new Exception($"Server {Name} not found.");

				server.Stop();
			}

		}
	}
}
