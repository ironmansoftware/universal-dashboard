using NLog;
using UniversalDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Language;
using UniversalDashboard.Execution;

namespace UniversalDashboard.Cmdlets
{
    public static class CmdletExtensions
    {
        public static string[] SkippedVariables = new[] { "args", "input", "psboundparameters", "pscommandpath", "foreach", "myinvocation", "psscriptroot", "DefaultVIServer", "DefaultVIServers"  };

        public static Endpoint TryGenerateEndpoint(this object obj, string id, System.Management.Automation.SessionState sessionState, object[] argumentList = null)
        {
            if (obj == null)
            {
                return null;
            }

            if (obj is Endpoint endpoint)
            {
                endpoint.Name = id;
                return endpoint;
            }

            if (obj is ScriptBlock scriptBlock)
            {
                return GenerateCallback(scriptBlock, id, sessionState);
            }

            throw new Exception($"Expected UDEndpoint or ScriptBlock but got {obj.GetType()}");
        }

        public static PowerShellEndpoint GenerateCallback(this ScriptBlock endpoint, string id, System.Management.Automation.SessionState sessionState, object[] argumentList = null)
        {
            if (endpoint == null) return null;

            var logger = LogManager.GetLogger("CallbackCmdlet");

            var callback = new PowerShellEndpoint();
            callback.Name = id;
            callback.ScriptBlock = endpoint;

            callback.Variables = new Dictionary<string, object>();
            callback.ArgumentList = argumentList;

            try
            {
                var variables = endpoint.Ast.FindAll(x => x is VariableExpressionAst, true).Cast<VariableExpressionAst>().Select(m => m.VariablePath.ToString());

                foreach(var variableName in variables)
                {
                    var variable = sessionState.PSVariable.Get(variableName);
                    if (variable != null && !variable.Options.HasFlag(ScopedItemOptions.Constant) && !variable.Options.HasFlag(ScopedItemOptions.ReadOnly))
                    {
                        if (!callback.Variables.ContainsKey(variable.Name))
                            callback.Variables.Add(variable.Name, sessionState.PSVariable.GetValue(variable.Name));
                    }
                }
            }
            catch (Exception ex)
            {
                logger.Error(ex, "Failed to look up variables.");
            }

            callback.SessionId = sessionState.PSVariable.Get(Constants.SessionId)?.Value as string;
            callback.Page = sessionState.PSVariable.Get(Constants.UDPage)?.Value as Page;

            EndpointService.Instance.Register(callback);

            return callback;
        }
    }
}
