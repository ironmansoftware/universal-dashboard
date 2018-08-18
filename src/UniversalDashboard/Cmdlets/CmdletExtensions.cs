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

            try
            {
                callback.Variables = new Dictionary<string, object>();

                var variables = endpoint.Ast.FindAll(x => x is VariableExpressionAst, true).Cast<VariableExpressionAst>().Select(m => m.VariablePath.ToString());

                foreach(var variableName in variables)
                {
                    var variable = sessionState.InvokeCommand.InvokeScript($"Get-Variable -Name '{variableName}'").Select(m => m.BaseObject).OfType<PSVariable>().FirstOrDefault();
                    if (variable != null)
                    {
                        callback.Variables.Add(variable.Name, sessionState.PSVariable.GetValue(variable.Name));
                    }
                }

                //var variables = sessionState.InvokeCommand.InvokeScript("Get-Variable")
                //                          .Select(m => m.BaseObject)
                //                          .OfType<PSVariable>()
                //                          .Where(m =>
                //                                 !SkippedVariables.Any(x => x.Equals(m.Name, StringComparison.OrdinalIgnoreCase)) &&
                //                                 m.GetType().Name != "SessionStateCapacityVariable" &&
                //                                 m.GetType().Name != "NullVariable" &&
                //                                 m.GetType().Name != "QuestionMarkVariable" &&
                //                                 !((m.Options & ScopedItemOptions.AllScope) == ScopedItemOptions.AllScope || (m.Options & ScopedItemOptions.Constant) == ScopedItemOptions.Constant || (m.Options & ScopedItemOptions.ReadOnly) == ScopedItemOptions.ReadOnly))
                //                          .Select(m => new KeyValuePair<string, object>(m.Name, sessionState.PSVariable.GetValue(m.Name)))
                //                          .ToArray();

                //

                callback.ArgumentList = argumentList;

                //
                //foreach (var variable in variables)
                //{
                //    if (callback.Variables.ContainsKey(variable.Key)) {
                //        callback.Variables[variable.Key] = variable.Value;       
                //    } else {
                //        callback.Variables.Add(variable.Key, variable.Value);
                //    }
                //}
            }
            catch (Exception ex)
            {
                logger.Error(ex, "Failed to look up variables.");
            }

            callback.SessionId = sessionState.PSVariable.Get(Constants.SessionId)?.Value as string;

            var dashboardService = sessionState.PSVariable.Get("DashboardService")?.Value as DashboardService;
            if (dashboardService != null)
            {
                dashboardService.EndpointService.Register(callback);
            }
            
            return callback;
        }
    }
}
