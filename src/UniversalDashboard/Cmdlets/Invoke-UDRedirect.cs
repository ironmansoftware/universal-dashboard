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
	[Cmdlet(VerbsLifecycle.Invoke, "UDRedirect")]
    public class InvokeRedirectCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(InvokeRedirectCommand));

        [Parameter(Mandatory = true)]
		public string Url { get; set; }

        protected override void EndProcessing()
        {
            var hub = this.GetVariableValue("DashboardHub") as IHubContext<DashboardHub>;
            var connectionId = this.GetVariableValue("ConnectionId") as string;   
            hub.Redirect(connectionId, Url).Wait();
		}
	}
}
