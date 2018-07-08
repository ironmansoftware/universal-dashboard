using Microsoft.AspNetCore.SignalR;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Hide, "UDModal")]
    public class HideModalCommand : PSCmdlet
    {
        protected override void EndProcessing()
        {
            var hub = this.GetVariableValue("DashboardHub") as IHubContext<DashboardHub>;
            if (hub != null)
            {
                var connectionId = this.GetVariableValue("ConnectionId") as string;
                hub.CloseModal(connectionId).Wait();
            }
        }
    }
}
