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
	[Cmdlet(VerbsCommon.Show, "UDToast")]
    public class ShowToastCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(ShowToastCommand));

        [Parameter(Mandatory = true, Position = 0)]
		public string Message { get; set; }
        [Parameter]
        public int Duration { get; set; } = 1000;
        [Parameter]
        public string Title { get; set; }
        
        [Parameter]
        public string Id { get; set; } = Guid.NewGuid().ToString();

        [Parameter()]
        [ValidateSet("bottomRight", "bottomLeft", "topRight", "topLeft", "topCenter", "bottomCenter", "center")]
        public string Position { get; set; } 

        [Parameter]
        public SwitchParameter CloseButton { get; set; }

        protected override void EndProcessing()
        {
            try 
            {
                var hub = this.GetVariableValue("DashboardHub") as IHubContext<DashboardHub>;
                var connectionId = this.GetVariableValue("ConnectionId") as string;   
                hub.ShowToast(connectionId, new {
                    close = CloseButton.IsPresent,
                    id = Id,
                    message = Message, 
                    title = Title,
                    timeout = Duration,
                    position = Position
                }).Wait();
            }
            catch (Exception ex) {
                 Log.Error(ex.Message);
            }
		}
	}
}
