
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
                    runspaceRef.Runspace.ResetRunspaceState();
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
                    SetVariable(ps, Constants.UDPage, context.Endpoint.Page);

                    if (context.User != null)
                    {
                        SetVariable(ps, "ClaimsPrinciple", context.User);
                        SetVariable(ps, "ClaimsPrincipal", context.User);
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

                                foreach(var errorRecord in ps.Streams.Error) {
                                    Log.Warn($"Error executing endpoint script. {errorRecord} {Environment.NewLine} {errorRecord.ScriptStackTrace}");
                                }

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

            return output.Where(m => m != null).Select(m => m.BaseObject);
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
        }
    }
}
