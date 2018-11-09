using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDTerminal")]
    public class NewTerminalCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewTerminalCommand));

		protected override void BeginProcessing()
		{
			var html = new Terminal();

			Log.Debug(JsonConvert.SerializeObject(html));

			WriteObject(html);
		}
	}
}
