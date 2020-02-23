using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Language;
using UniversalDashboard.Cmdlets;
using UniversalDashboard.Common.Models;

namespace UniversalDashboard.Models
{
    public class Endpoint : AbstractEndpoint
    {
        public Endpoint()
        {

        }

        public Endpoint(ScriptBlock scriptBlock)
        {
            ScriptBlock = scriptBlock;
        }

        public override Language Language => Language.PowerShell; 

        public ScriptBlock ScriptBlock { get; set; }

        public override bool HasCallback => ScriptBlock != null;

        public void Register(string id, PSCmdlet cmdlet)
        {
            if (!string.IsNullOrEmpty(Name))
            {
                // already registerd
                return;
            }

            Name = id;

            Variables = new Dictionary<string, object>();

            try
            {
                var variables = ScriptBlock.Ast.FindAll(x => x is VariableExpressionAst, true).Cast<VariableExpressionAst>().Select(m => m.VariablePath.ToString());

                foreach (var variableName in variables)
                {
                    var variable = cmdlet.SessionState.PSVariable.Get(variableName);
                    if (variable != null && !variable.Options.HasFlag(ScopedItemOptions.Constant) && !variable.Options.HasFlag(ScopedItemOptions.ReadOnly))
                    {
                        if (!Variables.ContainsKey(variable.Name))
                            Variables.Add(variable.Name, cmdlet.SessionState.PSVariable.GetValue(variable.Name));
                    }
                }
            }
            catch (Exception ex)
            {
                cmdlet.WriteWarning(ex.Message);
            }

            SessionId = cmdlet.SessionState.PSVariable.Get(Constants.SessionId)?.Value as string;
            Page = cmdlet.SessionState.PSVariable.Get(Constants.UDPage)?.Value as Page;

            var state = cmdlet.GetHostState();
            state.EndpointService.Register(this);
        }
    }
}
