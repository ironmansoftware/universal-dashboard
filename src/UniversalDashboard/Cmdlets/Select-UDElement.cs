using NLog;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Select, "UDElement")]
    public class SelectUDElementCommand : PSCmdlet
    {
		//private readonly Logger Log = LogManager.GetLogger(nameof(SelectUDElementCommand));

        [Parameter(Mandatory = true,ParameterSetName = "Normal")]
		public string ID { get; set; }

        [Parameter(ParameterSetName = "Normal")]
        public SwitchParameter ScrollToElement { get; set; }

        [Parameter(ParameterSetName = "ToTop")]
        public SwitchParameter ToTop { get; set; }
        protected override void EndProcessing()
        {
            var hub = this.GetCallbackService();
            var connectionId = this.GetVariableValue("ConnectionId") as string;   
            if (ParameterSetName == "Normal") {
                
                hub.Select(connectionId, ParameterSetName, ID, ScrollToElement.IsPresent).Wait();
            }
            if (ParameterSetName == "ToTop") {
                hub.Select(connectionId, ParameterSetName, null, false).Wait();    
            }
		}
	}
}
