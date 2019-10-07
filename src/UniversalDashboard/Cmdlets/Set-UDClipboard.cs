using NLog;
using System.Management.Automation;
using Microsoft.AspNetCore.SignalR;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Set, "UDClipboard")]
    public class SetUDClipboardCommand : PSCmdlet
    {
		//private readonly Logger Log = LogManager.GetLogger(nameof(InvokeRedirectCommand));

        [Parameter(Mandatory = true)]
		public string Data { get; set; }

        [Parameter]
        public SwitchParameter toastOnSuccess { get;  set; }

        [Parameter]
        public SwitchParameter toastOnError { get;  set; }

        protected override void EndProcessing()
        {
            var hub = this.GetVariableValue("DashboardHub") as IHubContext<DashboardHub>;
            var connectionId = this.GetVariableValue("ConnectionId") as string;   
            hub.Clipboard(connectionId, Data, toastOnSuccess, toastOnError).Wait();
		}
	}
}
