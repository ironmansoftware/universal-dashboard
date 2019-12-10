using NLog;
using System.Management.Automation;
using UniversalDashboard.Models.Basics;
using System.Linq;
using Microsoft.AspNetCore.SignalR;
using System.Security.Claims;
using Microsoft.Extensions.Caching.Memory;

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
            var hub = this.GetVariableValue("DashboardHub") as IHubContext<DashboardHub>;

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
