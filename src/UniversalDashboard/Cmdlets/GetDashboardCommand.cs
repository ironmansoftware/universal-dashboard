using NLog;
using System;
using System.Linq;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.Get, "UDDashboard")]
    public class GetDashboardCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(GetDashboardCommand));

		[Parameter]
		public string Name { get; set; }

	    protected override void EndProcessing()
	    {
			Log.Debug($"Name: {Name}");

		    var servers = string.IsNullOrEmpty(Name)
			    ? Server.Servers.Where(m => !m.IsRestApi).ToArray()
			    : Server.Servers.Where(m => !m.IsRestApi && m.Name.Equals(Name, StringComparison.OrdinalIgnoreCase)).ToArray();

		    foreach (var server in servers)
		    {
			    WriteObject(server);
		    }
		}
    }
}
