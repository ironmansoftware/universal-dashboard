using System.Collections.Generic;
using System.Management.Automation;
using System.Security.Claims;
using UniversalDashboard.Execution;
using UniversalDashboard.Interfaces;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsLifecycle.Invoke, "UDEndpoint")]
    public class InvokeEndpointCommand : PSCmdlet
    {
        [Parameter(Mandatory = true)]
        public string Id { get; set; }

        [Parameter()]
        public SwitchParameter Session { get; set; }

        [Parameter()]
        public SwitchParameter Wait { get; set; }

	    protected override void EndProcessing()
	    {
            var executionService = SessionState.PSVariable.GetValue(Constants.ExecutionService) as ILanguageExecutionService;
            if (executionService == null)
            {
                throw new System.Exception("Invoke-UDEndpoint can only be called from within an endpoint.");
            }

            var dashboardService = SessionState.PSVariable.GetValue(Constants.DashboardService) as IDashboardService;

            string sessionId = null;
            if (Session)
            {
                sessionId = SessionState.PSVariable.GetValue(Constants.SessionId) as string;
            }

            var endpoint = dashboardService.EndpointService.Get(Id, sessionId);

            if (endpoint == null)
            {
                throw new System.Exception($"Endpooint {Id} does not exist.");
            }

            var variables = new Dictionary<string, object>();
            var claimsPrincipal = SessionState.PSVariable.GetValue(Constants.ClaimsPrincipal) as ClaimsPrincipal;

            var executionContext = new ExecutionContext(endpoint, variables, new Dictionary<string, object>(), claimsPrincipal);

            if (Wait)
            {
                var result = executionService.ExecuteEndpoint(executionContext, endpoint);
                WriteObject(result);
            }
            else 
            {
                executionService.ExecuteEndpointAsync(executionContext, endpoint);
            }
	    }
    }
}
