using Microsoft.AspNetCore.SignalR;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Hide, "UDToast")]
    public class HideToastCommand : PSCmdlet
    {
        [Parameter(Mandatory = true, Position = 0)]
        public string Id { get; set; }
        protected override void EndProcessing()
        {
            var hub = this.GetVariableValue("DashboardHub") as IHubContext<DashboardHub>;
            if (hub != null)
            {
                var connectionId = this.GetVariableValue("ConnectionId") as string;
                hub.HideToast(connectionId, Id).Wait();
            }
        }
    }
}
