using System;
using System.Collections.Generic;
using System.Management.Automation;
using System.Text.RegularExpressions;
using UniversalDashboard.Models;
using UniversalDashboard.Services;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDEndpoint", DefaultParameterSetName = "Generic")]
    public class NewEndpointCommand : PSCmdlet
    {
		[Parameter(Mandatory = true)]
		public ScriptBlock Endpoint { get; set; }

        [Parameter]
        public object[] ArgumentList { get; set; }

        [Parameter]
        public string Id { get; set; } = Guid.NewGuid().ToString();

		[Parameter(Mandatory = true, ParameterSetName = "Rest")]
		public string Url { get; set; }

        [Parameter(ParameterSetName = "Rest")]
        public SwitchParameter EvaluateUrlAsRegex { get; set; }

		[Parameter(ParameterSetName = "Rest")]
		[ValidateSet("GET", "POST", "DELETE", "PUT")]
		public string Method { get; set; } = "GET";

        [Parameter(Mandatory = true, ParameterSetName = "Scheduled")]
        public EndpointSchedule Schedule { get; set; }

	    protected override void EndProcessing()
	    {
            var callback = new Endpoint
            {
                Name = Id,
                Url = Url,
                Method = Method,
                ScriptBlock = Endpoint,
                Schedule = Schedule,
                ArgumentList = ArgumentList
		    };

            if (EvaluateUrlAsRegex) {
                callback.UrlRegEx = new Regex(Url);
            }

            callback.SessionId = SessionState.PSVariable.Get(Constants.SessionId)?.Value as string;

            Execution.EndpointService.Instance.Register(callback);

            WriteObject(callback);
	    }
    }
}
