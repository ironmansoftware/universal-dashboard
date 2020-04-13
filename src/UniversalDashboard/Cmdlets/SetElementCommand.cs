using NLog;
using System.Management.Automation;
using System.Collections;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Set, "UDElement")]
    public class SetElementCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(SetElementCommand));

        [Parameter(Mandatory = true)]
		public string Id { get; set; }

        [Parameter]
        public Hashtable Properties { get; set; }

        [Parameter]
        public SwitchParameter Broadcast { get; set; }

        protected override void EndProcessing()
        {
            var hub = this.GetCallbackService();

            if (Broadcast)
            {
                hub.SetState(Id, Properties).Wait();
            }
            else
            {
                var connectionId = this.GetVariableValue("ConnectionId") as string;   
                hub.SetState(connectionId, Id, Properties).Wait();
            }


		}
	}
}
