using NLog;
using UniversalDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    public class CallbackCmdlet : ComponentCmdlet
    {
		[Parameter]
		public ScriptBlock Endpoint { get; set; }

		[Parameter]
	    public SwitchParameter AutoRefresh { get; set; }

	    [Parameter]
	    public int RefreshInterval { get; set; } = 5;

		[Parameter]
		public SwitchParameter DebugEndpoint { get; set;}
        protected Endpoint GenerateCallback(string id)
        {
            return Endpoint.GenerateCallback(id, SessionState, DebugEndpoint);
        }

        protected Endpoint GenerateCallback(string id, ScriptBlock endpoint)
        {
            return endpoint.GenerateCallback(id, SessionState, DebugEndpoint);
        }
    }

	public class ColoredCallbackCmdlet : ColoredComponentCmdlet
    {
		[Parameter]
		public ScriptBlock Endpoint { get; set; }

		[Parameter]
	    public SwitchParameter AutoRefresh { get; set; }

	    [Parameter]
	    public int RefreshInterval { get; set; } = 5;

		[Parameter]
		public SwitchParameter DebugEndpoint { get; set;}

		protected Endpoint GenerateCallback()
		{
			var logger = LogManager.GetLogger("CallbackCmdlet");

			var callback = new Endpoint();
			callback.Debug = DebugEndpoint;
			callback.ScriptBlock = Endpoint;

			try
			{
				var variables = SessionState.InvokeCommand.InvokeScript("Get-Variable")
										  .Select(m => m.BaseObject)
										  .OfType<PSVariable>()
										  .Where(m =>
												 !CmdletExtensions.SkippedVariables.Any(x => x.Equals(m.Name, StringComparison.OrdinalIgnoreCase)) &&
												 m.GetType().Name != "SessionStateCapacityVariable" &&
												 m.GetType().Name != "NullVariable" &&
												 m.GetType().Name != "QuestionMarkVariable" &&
												 !((m.Options & ScopedItemOptions.AllScope) == ScopedItemOptions.AllScope || (m.Options & ScopedItemOptions.Constant) == ScopedItemOptions.Constant || (m.Options & ScopedItemOptions.ReadOnly) == ScopedItemOptions.ReadOnly))
										  .Select(m => new KeyValuePair<string, object>(m.Name, m.Value))
										  .ToArray();

				callback.Variables = new Dictionary<string, object>();
				foreach (var variable in variables)
					callback.Variables.Add(variable.Key, variable.Value);

				callback.Modules = SessionState.InvokeCommand.InvokeScript("Get-Module")
														.Select(m => m.BaseObject)
														.OfType<PSModuleInfo>()
														.Select(m => m.Path)
														.ToList();
			}
			catch (Exception ex)
			{
				logger.Error(ex, "Failed to look up variables.");
			}


			return callback;
		}
	}
}
