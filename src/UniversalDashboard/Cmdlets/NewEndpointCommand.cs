using System;
using System.Collections.Generic;
using System.Management.Automation;
using System.Management.Automation.Language;
using System.Text.RegularExpressions;
using UniversalDashboard.Models;
using UniversalDashboard.Services;
using System.Linq;

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

            callback.Variables = new Dictionary<string, object>();

            try
            {
                var variables = Endpoint.Ast.FindAll(x => x is VariableExpressionAst, true).Cast<VariableExpressionAst>().Select(m => m.VariablePath.ToString());

                foreach (var variableName in variables)
                {
                    var variable = SessionState.InvokeCommand.InvokeScript($"Get-Variable -Name '{variableName}' -ErrorAction SilentlyContinue").Select(m => m.BaseObject).OfType<PSVariable>().FirstOrDefault();
                    if (variable != null && !variable.Options.HasFlag(ScopedItemOptions.Constant) && !variable.Options.HasFlag(ScopedItemOptions.ReadOnly))
                    {
                        if (!callback.Variables.ContainsKey(variable.Name))
                            callback.Variables.Add(variable.Name, SessionState.PSVariable.GetValue(variable.Name));
                    }
                }
            }
            catch (Exception ex)
            {
                WriteWarning(ex.Message);
            }


            if (EvaluateUrlAsRegex) {
                callback.UrlRegEx = new Regex(Url);
            }

            callback.SessionId = SessionState.PSVariable.Get(Constants.SessionId)?.Value as string;
            callback.Page = SessionState.PSVariable.Get(Constants.UDPage)?.Value as Page;

            if (callback.Schedule == null) 
            {
                Execution.EndpointService.Instance.Register(callback);
            }
            
            WriteObject(callback);
	    }
    }
}
