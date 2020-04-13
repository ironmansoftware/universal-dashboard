using NLog;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsData.Sync, "UDElement")]
    public class SyncElementCommand : PSCmdlet
    {
        private readonly Logger Log = LogManager.GetLogger(nameof(SyncElementCommand));

        [Parameter(Mandatory = true, ValueFromPipeline = true)]
        public string[] Id { get; set; }
        [Parameter]
        public SwitchParameter Broadcast { get; set; }

        protected override void ProcessRecord()
        {
            var hub = this.GetCallbackService();

            if (hub == null)
            {
                throw new System.Exception("Cannot call Sync-UDElement out side of an endpoint block.");
            }

            foreach(var id in Id) 
            {
                if (Broadcast)
                {
                    hub.SyncElement(id).Wait();
                }
                else
                {
                    var connectionId = this.GetVariableValue("ConnectionId") as string;
                    hub.SyncElement(connectionId, id).Wait();
                }
            }            
        }
    }
}
