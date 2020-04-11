using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Remove, "UDEndpoint")]
    public class RemoveEndpointCommand : PSCmdlet
    {
        [Parameter(Mandatory = true)]
        public string Id { get; set; }

	    protected override void EndProcessing()
	    {
            var state = this.GetHostState();
            state.EndpointService.Unregister(Id, null);
	    }
    }
}
