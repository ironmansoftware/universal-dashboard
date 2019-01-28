using NLog;
using System.Management.Automation;
using System.Linq;
using Microsoft.AspNetCore.SignalR;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Add, "UDElement")]
    public class AddElementCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(AddElementCommand));

        [Parameter(Mandatory = true)]
		public string ParentId { get; set; }
        [Parameter]
		public ScriptBlock Content { get; set; }
        [Parameter]
        public SwitchParameter Broadcast { get; set; }

        protected override void EndProcessing()
        {
            var content = Content?.Invoke().Select(m => m.BaseObject).ToArray();

            var hub = this.GetVariableValue("DashboardHub") as IHubContext<DashboardHub>;

            if (Broadcast)
            {
                hub.AddElement(ParentId, content).Wait();
            }
            else
            {
                var connectionId = this.GetVariableValue("ConnectionId") as string;   
                hub.AddElement(connectionId, ParentId, content).Wait();
            }
		}
	}
}
