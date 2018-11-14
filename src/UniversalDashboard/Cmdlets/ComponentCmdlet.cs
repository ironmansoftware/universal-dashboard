using System;
using System.Management.Automation;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets
{
    public class ComponentCmdlet : PSCmdlet
    {
		[Parameter]
		public string Id { get; set; } = Guid.NewGuid().ToString();

        internal IDashboardService DashboardService
        {
            get
            {
                return SessionState.PSVariable.Get(Constants.DashboardService)?.Value as IDashboardService;
            }
        }

        internal string SessionId
        {
            get
            {
                return SessionState.PSVariable.Get(Constants.SessionId)?.Value as string;
            }
        }
    }

	public class ColoredComponentCmdlet : ComponentCmdlet {
		[Parameter]
		public DashboardColor BackgroundColor { get; set; }
		
		[Parameter]
		public DashboardColor FontColor { get; set; }
		
	}
}
