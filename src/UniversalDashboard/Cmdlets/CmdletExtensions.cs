using NLog;
using UniversalDashboard.Models;
using UniversalDashboard.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    public static class CmdletExtensions
    {
        public static string[] SkippedVariables = new[] { "args", "input", "psboundparameters", "pscommandpath", "foreach", "myinvocation", "psscriptroot", "DefaultVIServer", "DefaultVIServers"  };

        public static Endpoint GenerateCallback(this ScriptBlock endpoint, string id, System.Management.Automation.SessionState sessionState, bool debugEndpoint)
        {
            var logger = LogManager.GetLogger("CallbackCmdlet");

            var callback = new Endpoint();
            callback.Name = id;
            callback.Debug = debugEndpoint;
            callback.ScriptBlock = endpoint;

            try
            {
                var variables = sessionState.InvokeCommand.InvokeScript("Get-Variable")
                                          .Select(m => m.BaseObject)
                                          .OfType<PSVariable>()
                                          .Where(m =>
                                                 !SkippedVariables.Any(x => x.Equals(m.Name, StringComparison.OrdinalIgnoreCase)) &&
                                                 m.GetType().Name != "SessionStateCapacityVariable" &&
                                                 m.GetType().Name != "NullVariable" &&
                                                 m.GetType().Name != "QuestionMarkVariable" &&
                                                 !((m.Options & ScopedItemOptions.AllScope) == ScopedItemOptions.AllScope || (m.Options & ScopedItemOptions.Constant) == ScopedItemOptions.Constant || (m.Options & ScopedItemOptions.ReadOnly) == ScopedItemOptions.ReadOnly))
                                          .Select(m => new KeyValuePair<string, object>(m.Name, sessionState.PSVariable.GetValue(m.Name)))
                                          .ToArray();

                // var property = sessionState.GetType().GetProperty("Internal", System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                // var internalVariables = property.GetValue(sessionState, null);
                // var variableTable = internalVariables.GetType().GetMethod("GetVariableTable", System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                // var variableTableInstance = variableTable.Invoke(internalVariables, null);

                callback.Variables = new Dictionary<string, object>();
                foreach (var variable in variables)
                {
                    if (callback.Variables.ContainsKey(variable.Key)) {
                        callback.Variables[variable.Key] = variable.Value;       
                    } else {
                        callback.Variables.Add(variable.Key, variable.Value);
                    }
                }
                    
                callback.Modules = sessionState.InvokeCommand.InvokeScript("Get-Module")
                                                        .Select(m => m.BaseObject)
                                                        .OfType<PSModuleInfo>()
                                                        .Select(m => m.Path)
                                                        .ToList();
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
