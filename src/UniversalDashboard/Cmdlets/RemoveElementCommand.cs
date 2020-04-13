using NLog;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Remove, "UDElement")]
    public class RemoveElementCommand : PSCmdlet
    {
        private readonly Logger Log = LogManager.GetLogger(nameof(SetElementCommand));

        [Parameter(Mandatory = true)]
        public string Id { get; set; }
        [Parameter()]
        public string ParentId { get; set; }

        [Parameter]
        public SwitchParameter Broadcast { get; set; }

        protected override void EndProcessing()
        {
            var hub = this.GetCallbackService();

            if (Broadcast)
            {
                hub.RemoveElement(Id, ParentId).Wait();
            }
            else
            {
                var connectionId = this.GetVariableValue("ConnectionId") as string;   
                hub.RemoveElement(Id, ParentId).Wait();
            }
        }
    }
}
