using UniversalDashboard.Models;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    public class CallbackCmdlet : ComponentCmdlet
    {
		[Parameter]
		public ScriptBlock Endpoint { get; set; }

        [Parameter]
        public object[] ArgumentList { get; set; }

        [Parameter]
	    public SwitchParameter AutoRefresh { get; set; }

	    [Parameter]
	    public int RefreshInterval { get; set; } = 5;

        protected Endpoint GenerateCallback(string id)
        {
            return Endpoint.GenerateCallback(id, SessionState, ArgumentList);
        }

        protected Endpoint GenerateCallback(string id, ScriptBlock endpoint, object[] argumentList)
        {
            return endpoint.GenerateCallback(id, SessionState, argumentList);
        }
    }
}
