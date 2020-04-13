using NLog;
using System.Management.Automation;
using Microsoft.AspNetCore.SignalR;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsLifecycle.Invoke, "UDRedirect")]
    public class InvokeRedirectCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(InvokeRedirectCommand));

        [Parameter(Mandatory = true)]
		public string Url { get; set; }

        [Parameter]
        public SwitchParameter OpenInNewWindow { get;  set; }

        protected override void EndProcessing()
        {
            var hub = this.GetCallbackService();
            var connectionId = this.GetVariableValue("ConnectionId") as string;   
            hub.Redirect(connectionId, Url, OpenInNewWindow.IsPresent).Wait();
		}
	}
}
