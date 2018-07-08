using System.Management.Automation;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDEndpoint")]
    public class NewEndpointCommand : PSCmdlet
    {
		[Parameter(Mandatory = true)]
		public ScriptBlock Endpoint { get; set; }

		[Parameter(Mandatory = true, ParameterSetName = "Rest")]
		public string Url { get; set; }

		[Parameter(ParameterSetName = "Rest")]
		[ValidateSet("GET", "POST", "DELETE", "PUT")]
		public string Method { get; set; } = "GET";

        [Parameter(Mandatory = true, ParameterSetName = "Scheduled")]
        public EndpointSchedule Schedule { get; set; }

	    protected override void EndProcessing()
	    {
		    var callback = new Endpoint
		    {
                Url = Url,
                Method = Method,
			    ScriptBlock = Endpoint,
                Schedule = Schedule
		    };

		    WriteObject(callback);
	    }
    }
}
