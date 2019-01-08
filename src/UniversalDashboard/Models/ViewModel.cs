using System;
using System.Collections;
using System.Collections.Generic;
using System.Management.Automation;
using DotNetify;
using UniversalDashboard.Execution;

namespace UniversalDashboard.Models
{
    public class ViewModel : BaseVM
    {
        private readonly IEnumerable<ViewModel> _subViewModels;
        private readonly IExecutionService _executionService;
        private readonly PSObject _this;
        
        public Hashtable Members { get; set; }
        public string Name { get; set; }

        public ViewModel(string name, Hashtable members)
        {
            Name = name;
            Members = members;

            foreach (DictionaryEntry item in members)
            {
                AddProperty(item.Key.ToString(), item.Value);
            }
        }

        internal ViewModel(IExecutionService executionService, Hashtable members)
        {
            _executionService = executionService;

            _this = new PSObject(this);
            

            foreach (DictionaryEntry item in members)
            {
                if (item.Value is PSObject psobject && psobject.BaseObject is Endpoint endpoint)
                {
                    AddProperty(item.Key.ToString(), new Action<string>(value => ExecuteEndpoint(value, endpoint)));
                }
                else
                {
                    AddProperty(item.Key.ToString(), item.Value);
                    _this.Properties.Add(new PSScriptProperty(
                        item.Key.ToString(), 
                        ScriptBlock.Create($"$this.Get('{item.Key.ToString()}')"),
                        ScriptBlock.Create($"param($Value) $this.Set('{item.Key.ToString()}', $Value)")));
                }
            }
        }

        public void Set(string name, object value)
        {
            Set(value, name);
        }

        public object Get(string name)
        {
            return Get<object>(name);
        }

        private void ExecuteEndpoint(string value, Endpoint endpoint)
        {
            var variables = new Dictionary<string, object>();
            var parameters = new Dictionary<string, object>();
            var executionContext = new ExecutionContext(endpoint, variables, parameters, null);
            executionContext.Variables.Add("this", _this);
            executionContext.Variables.Add("EventData", value);
            _executionService.ExecuteEndpoint(executionContext, endpoint);
        }
    }
}
