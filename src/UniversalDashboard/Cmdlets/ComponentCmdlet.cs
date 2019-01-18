using System;
using System.Collections.Generic;
using System.Linq;
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

        protected IEnumerable<T> GetItemsFromScriptBlock<T>(ScriptBlock scriptBlock)
        {
            if (scriptBlock == null)
            {
                return null;
            }

            return scriptBlock.Invoke().Select(m => m.BaseObject).Cast<T>();
        }
    }

	public class ColoredComponentCmdlet : ComponentCmdlet {
		[Parameter]
		public DashboardColor BackgroundColor { get; set; }
		
		[Parameter]
		public DashboardColor FontColor { get; set; }
		
	}
}
