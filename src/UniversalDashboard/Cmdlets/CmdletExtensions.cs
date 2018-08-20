using NLog;
using UniversalDashboard.Models;
using UniversalDashboard.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Language;

namespace UniversalDashboard.Cmdlets
{
    public static class CmdletExtensions
    {
        public static string[] SkippedVariables = new[] { "args", "input", "psboundparameters", "pscommandpath", "foreach", "myinvocation", "psscriptroot", "DefaultVIServer", "DefaultVIServers"  };

        public static Endpoint GenerateCallback(this ScriptBlock endpoint, string id, System.Management.Automation.SessionState sessionState, object[] argumentList = null)
        {
            var logger = LogManager.GetLogger("CallbackCmdlet");

            var callback = new Endpoint();
            callback.Name = id;
            callback.ScriptBlock = endpoint;

            callback.Variables = new Dictionary<string, object>();
            callback.ArgumentList = argumentList;

            try
            {
                var variables = endpoint.Ast.FindAll(x => x is VariableExpressionAst, true).Cast<VariableExpressionAst>().Select(m => m.VariablePath.ToString());

                foreach(var variableName in variables)
                {
                    var variable = sessionState.InvokeCommand.InvokeScript($"Get-Variable -Name '{variableName}'").Select(m => m.BaseObject).OfType<PSVariable>().FirstOrDefault();
                    if (variable != null && !variable.Options.HasFlag(ScopedItemOptions.Constant) && !variable.Options.HasFlag(ScopedItemOptions.ReadOnly))
                    {
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

            var dashboardService = sessionState.PSVariable.Get("DashboardService")?.Value as DashboardService;
            if (dashboardService != null)
            {
                dashboardService.EndpointService.Register(callback);
            }

            return callback;
        }
    }
}
