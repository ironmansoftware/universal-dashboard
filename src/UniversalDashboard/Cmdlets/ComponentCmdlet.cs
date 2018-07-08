using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Threading.Tasks;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets
{
    public class ComponentCmdlet : PSCmdlet
    {
		[Parameter]
		public string Id { get; set; } = Guid.NewGuid().ToString();
	}

	public class ColoredComponentCmdlet : ComponentCmdlet {
		[Parameter]
		public DashboardColor BackgroundColor { get; set; }
		
		[Parameter]
		public DashboardColor FontColor { get; set; }
		
	}
}
