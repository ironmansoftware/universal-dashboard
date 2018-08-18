
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Caching.Memory;
using NLog;
using UniversalDashboard.Models;
using UniversalDashboard.Services;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Language;
using System.Management.Automation.Runspaces;
using System.Text;
using UniversalDashboard.Interfaces;

namespace UniversalDashboard.Execution
{

    public class ExecutionResult
    {        
        public object Result { get; set; }
    }

	public interface IExecutionService {
		object ExecuteEndpoint(ExecutionContext context, Endpoint endpoint);
    }
    public class ExecutionService : IExecutionService {
        private static readonly Logger Log = LogManager.GetLogger(nameof(ExecutionService));
		private readonly IUDRunspaceFactory _runspace;
		private static IMemoryCache _memoryCache;
		private readonly IDashboardService _dashboardService;
        private readonly IHubContext<DashboardHub> _hubContext;
        private readonly StateRequestService _stateRequestService;

        public static IMemoryCache MemoryCache {
            get {
                if (_memoryCache == null) {
                    _memoryCache = new MemoryCache(new MemoryCacheOptions {
                    });
                }
                return _memoryCache;
            }
        }

        public ExecutionService(IDashboardService dashboardService, IHubContext<DashboardHub> hubContext, StateRequestService stateRequestService)
		{
			Log.Debug("ExecutionService constructor");

			_runspace = dashboardService.RunspaceFactory;
			_dashboardService = dashboardService;
            _hubContext = hubContext;
            _stateRequestService = stateRequestService;
        }

        public object ExecuteEndpoint(ExecutionContext context, Endpoint endpoint)
        {
            var script = endpoint.ScriptBlock.ToString();
            var scriptBlockAst = endpoint.ScriptBlock.Ast as ScriptBlockAst;
            
            if (scriptBlockAst.ParamBlock == null && context.Parameters.Any())
            {
                if (Log.IsDebugEnabled)
                {
                    Log.Debug("Parameters--------------");
                    foreach (var variable in context.Parameters)
                    {
                        Log.Debug($"{variable.Key} = {variable.Value}");
                    }
                }

                var paramBlockBuilder = new StringBuilder();
                paramBlockBuilder.Append("param(");

                foreach (var parameter in context.Parameters)
                {
                    paramBlockBuilder.Append($"${parameter.Key},");
                }
                paramBlockBuilder.Remove(paramBlockBuilder.Length - 1, 1);
                paramBlockBuilder.Append(")");
                paramBlockBuilder.AppendLine();

                script = paramBlockBuilder.ToString() + script;
            }

            Collection<PSObject> output;
            string json;
            using (var ps = PowerShell.Create())
			{
                using (var runspaceRef =  _runspace.GetRunspace())
                {
                    Runspace.DefaultRunspace = runspaceRef.Runspace;

                    

                    ps.Runspace = runspaceRef.Runspace;

                    if (endpoint.Variables != null)
                    {
                        Log.Debug("Scope variables--------------");
                        SetVariables(ps.Runspace, endpoint.Variables);
                    }

                    if (context.Variables != null)
                    {
                        Log.Debug("Context variables--------------");
                        SetVariables(ps.Runspace, context.Variables);
                    }

                    SetVariable(ps, "DashboardHub", _hubContext);
                    SetVariable(ps, "Cache", MemoryCache);
                    SetVariable(ps, "StateRequestService", _stateRequestService);
                    SetVariable(ps, "ConnectionId", context.ConnectionId);
                    SetVariable(ps, Constants.SessionId, context.SessionId);
                    SetVariable(ps, "ArgumentList", context.Endpoint.ArgumentList?.ToList());

                    if (context.User != null)
                    {
                        SetVariable(ps, "ClaimsPrinciple", context.User);
                    }

                    ps.AddStatement().AddScript(script);

                    foreach (var parameter in context.Parameters)
                    {
                        ps.AddParameter(parameter.Key, parameter.Value);
                    }

                    try
                    {
                        output = ps.Invoke();

                        if (ps.HadErrors)
                        {
                            if (ps.Streams.Error.Any()) {
                                var error = ps.Streams.Error[0].Exception.Message;

                                Log.Warn($"Error executing endpoint script. {error}");

                                return new { Error = new Error { Message = error } };
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Log.Warn(ex, "Error executing endpoint script.");

                        return new { Error = new Error { Message = ex.Message, Location = ex.StackTrace } };
                    }
                }
			}

			if (context.NoSerialization) {
                return output.Select(m => m.BaseObject).ToArray();
            }

			json = output.FirstOrDefault()?.BaseObject as string;
            if (json != null)
            {
                return json;
            }

            if (!output.Where(m => m != null).Select(m => m.BaseObject).OfType<InputAction>().Any() && !output.Where(m => m != null).Select(m => m.BaseObject).OfType<Component>().Any())
            {
                return output.Where(m => m != null).Select(m => m.BaseObject);
            }

            return FindComponents(output);
        }

        private string ReplaceIfNotReplaced(string script, string valueToReplace, string replacementValue)
        {
            if(script.Contains(valueToReplace) && !script.Contains(replacementValue))
            {
                script = script.Replace(valueToReplace, replacementValue);
            }
            else
            {
                Log.Debug("Args already replaced in execution script.");
            }
            return script;
        }

        private string SetupSharedData(PowerShell ps, string script, ExecutionContext context, out bool hasGetSharedData)
        {
            bool hasPublishSharedData = script.Contains("Publish-UDSharedData");
            hasGetSharedData = script.Contains("Get-UDSharedData");

            if (hasPublishSharedData || hasGetSharedData)
            {
                ps.AddStatement()
                 .AddCommand("Set-Variable", true)
                 .AddParameter("Name", "MemoryCacheUdShared")
                 .AddParameter("Value", MemoryCache);
            }

            if (hasPublishSharedData)
            {
                script = ReplaceIfNotReplaced(script, "Publish-UDSharedData ", "Publish-UDSharedData -MemoryCache $MemoryCacheUdShared ");
            }

            if (hasGetSharedData)
            {
                ps.AddStatement()
                 .AddCommand("Set-Variable", true)
                 .AddParameter("Name", "ExecutionContextUdShared")
                 .AddParameter("Value", context);

                ps.AddStatement()
                 .AddCommand("Set-Variable", true)
                 .AddParameter("Name", "ExecutionServiceUdShared")
                 .AddParameter("Value", this);

                script = ReplaceIfNotReplaced(script, "Get-UDSharedData ", "Get-UDSharedData -ExecutionContext $ExecutionContextUdShared -ExecutionService $ExecutionServiceUdShared -MemoryCache $MemoryCacheUdShared ");
            }

            return script;
        }

        private IEnumerable<object> FindComponents(Collection<PSObject> output) {
			var inputActionComponents = output.Select(m => m.BaseObject).OfType<InputAction>().Where(m => m.Type == InputAction.Content).SelectMany(m => m.Components);
			var components = output.Select(m => m.BaseObject).OfType<Component>().ToArray();
			var endpoints = inputActionComponents.Concat(components).ToArray();

			if (endpoints.Any())
			{
				Log.Debug("Endpoint returned new components: " + endpoints.Count());

				var dashboardBuilder = new DashboardBuilder();
				var app = dashboardBuilder.Build(endpoints);

				foreach (var newEndpoint in app.Endpoints)
				{
					if (newEndpoint.ScriptBlock == null || newEndpoint.Name == null) continue;
                    _dashboardService.EndpointService.Register(newEndpoint);
				}

				if (app.ElementScripts != null) {
					foreach(var elementScript in app.ElementScripts) {
						if (_dashboardService.ElementScripts.ContainsKey(elementScript.Key))
						{
							Log.Debug("Found new element script: " + elementScript.Value);
							_dashboardService.ElementScripts.Add(elementScript.Key, elementScript.Value);
						}
					}
				}
			}

			if (components.Any())
			{
				return components;
			}

			return output.Select(m => m.BaseObject).ToArray();
		}

		private void SetVariables(Runspace runspace, Dictionary<string, object> variables) {
			foreach (var variable in variables)
			{
				if (Log.IsDebugEnabled)
				{
					Log.Debug($"{variable.Key} = {variable.Value}");
				}

                runspace.SessionStateProxy.SetVariable(variable.Key, variable.Value);
			}
		}

        private void SetVariable(PowerShell powershell, string name, object value)
        {
            if (Log.IsDebugEnabled)
            {
                Log.Debug($"{name} = {value}");
            }

            powershell.AddStatement()
                 .AddCommand("Set-Variable", true)
                 .AddParameter("Name", name)
                 .AddParameter("Value", value);

            //runspace.SessionStateProxy.SetVariable(name, value);
        }
    }
}
