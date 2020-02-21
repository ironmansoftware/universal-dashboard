using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using UniversalDashboard.Models.Enums;
using UniversalDashboard.Models.Basics;
using System.Collections;
using System.Linq;
using System.Collections.Generic;
using Microsoft.AspNetCore.SignalR;
using System.Security.Claims;
using Microsoft.Extensions.Caching.Memory;

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
            var hub = this.GetVariableValue("DashboardHub") as IHubContext<DashboardHub>;

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
