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
using System;
using Microsoft.Extensions.Caching.Memory;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommunications.Send, "UDToast")]
    public class SendToastCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(SendToastCommand));

        [Parameter(Mandatory = true, Position = 0)]
		public string Message { get; set; }
        [Parameter]
        public int Duration { get; set; } = 1000;

        protected override void EndProcessing()
        {
            try 
            {
                var hub = this.GetVariableValue("DashboardHub") as IHubContext<DashboardHub>;
                var connectionId = this.GetVariableValue("ConnectionId") as string;   
                hub.SendToast(connectionId, Message, Duration).Wait();
            }
            catch (Exception ex) {
                 Log.Error(ex.Message);
            }
		}
	}
}
