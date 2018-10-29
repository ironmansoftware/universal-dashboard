using System.Management.Automation;
using UniversalDashboard.Models;
using Newtonsoft.Json;
using NLog;
using System;
using UniversalDashboard.Services;
using System.Linq;
using UniversalDashboard.Models.Basics;
using System.Management.Automation.Runspaces;
using System.Collections.Generic;
using System.IO;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDEndpointInitialization")]
	public class NewEndpointInitializationCommand : PSCmdlet
	{
        [Parameter]
        public string[] Variable { get; set; }
        [Parameter]
        public string[] Module { get; set; }
        [Parameter]
        public string[] Function { get; set; }

        protected override void EndProcessing() {
            var initialSessionState = InitialSessionState.CreateDefault();
            if (Variable != null) {
                foreach(var variable in Variable) {
                    var value = SessionState.PSVariable.GetValue(variable);
                    initialSessionState.Variables.Add(new SessionStateVariableEntry(variable, value, string.Empty));
                }
            }

            if (Module != null) {

                var resolvedModules = new List<string>();
                foreach(var module in Module)
                {
                    if (Path.IsPathRooted(module))
                    {
                        resolvedModules.Add(module);
                    }
                    else
                    {
                        var resolvedPath = Path.Combine(MyInvocation.PSScriptRoot, module);
                        resolvedModules.Add(resolvedPath);
                    }
                }

                initialSessionState.ImportPSModule(resolvedModules.ToArray());
            }

            if (Function != null) {
                foreach(var function in Function) {
                    var functionInfo = SessionState.InvokeCommand.GetCommand(function, CommandTypes.Function);

                    initialSessionState.Commands.Add(new SessionStateFunctionEntry(function, functionInfo.Definition));
                }
            }

            WriteObject(initialSessionState);
        }
    }
}