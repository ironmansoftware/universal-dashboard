using NLog;
using UniversalDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Language;
using UniversalDashboard.Execution;
using UniversalDashboard.Interfaces;

namespace UniversalDashboard.Cmdlets
{
    public static class CmdletExtensions
    {
        public static string[] SkippedVariables = new[] { "args", "input", "psboundparameters", "pscommandpath", "foreach", "myinvocation", "psscriptroot", "DefaultVIServer", "DefaultVIServers"  };

        internal static HostState HostState;

        static CmdletExtensions()
        {
            HostState = new HostState
            {
                EndpointService = new EndpointService()
            };
        }

        public static HostState GetHostState(this PSCmdlet cmdlet)
        {
            if (cmdlet.Host.Name != "UDHost")
            {
                return HostState;
            }

            return cmdlet.Host.PrivateData.BaseObject as HostState;
        }

        public static IDashboardCallbackService GetCallbackService(this PSCmdlet cmdlet)
        {
            var hub = cmdlet.GetVariableValue(Constants.DashboardCallbackService) as IDashboardCallbackService;
            if (hub == null)
            {
                throw new Exception("This cmdlet can only be caused from within a Universal Dashboard endpoint.");
            }
            return hub;
        }

        public static IStateRequestService GetStateRequestService(this PSCmdlet cmdlet)
        {
            var service = cmdlet.GetVariableValue(Constants.StateRequestService) as IStateRequestService;
            if (service == null)
            {
                throw new Exception("This cmdlet can only be caused from within a Universal Dashboard endpoint.");
            }
            return service;
        }

        public static Endpoint TryGenerateEndpoint(this object obj, string id, PSCmdlet cmdlet, System.Management.Automation.SessionState sessionState, object[] argumentList = null)
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
                return GenerateCallback(scriptBlock, id, cmdlet, sessionState);
            }

            throw new Exception($"Expected UDEndpoint or ScriptBlock but got {obj.GetType()}");
        }

        public static Endpoint GenerateCallback(this ScriptBlock endpoint, string id, PSCmdlet cmdlet, System.Management.Automation.SessionState sessionState, object[] argumentList = null)
        {
            if (endpoint == null) return null;

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

            var hostState = cmdlet.GetHostState();
            hostState.EndpointService.Register(callback);

            return callback;
        }
    }
}
