using NLog;
using System.Management.Automation;
using Microsoft.AspNetCore.SignalR;
using System;
using UniversalDashboard.Services;
using System.Collections;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Get, "UDElement")]
    public class GetElementCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(GetElementCommand));

        [Parameter(Mandatory = true)]
		public string Id { get; set; }

        private string _requestId;

        protected override void BeginProcessing()
        {
            var hub = this.GetCallbackService();
            var connectionId = this.GetVariableValue("ConnectionId") as string;  

            _requestId = Guid.NewGuid().ToString();
            hub.RequestState(connectionId, Id, _requestId).ConfigureAwait(false);
        }

        protected override void EndProcessing()
		{
            var stateRequestService = this.GetVariableValue("StateRequestService") as StateRequestService;

            var retry = 0;
            while(retry < 10) {
                if (!stateRequestService.TryGet(_requestId, out Hashtable value)) {
                    stateRequestService.EventAvailable.WaitOne(100);
                    retry++;
                    continue;
                }

                WriteObject(value);
                break;
            }
		}
	}
}
