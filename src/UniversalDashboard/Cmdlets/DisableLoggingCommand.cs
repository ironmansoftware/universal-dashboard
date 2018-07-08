using NLog;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsLifecycle.Disable, "UDLogging")]
    public class DisableLoggingCommand : PSCmdlet
    {
		protected override void EndProcessing()
		{
			LogManager.DisableLogging();
		}
	}
}
