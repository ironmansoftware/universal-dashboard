using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    //TODO: Eventually we should let users expose this but it's a pretty big security risk. 
    //TODO: will need to implement some controls to lock this down.
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
