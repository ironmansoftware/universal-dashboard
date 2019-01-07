using System;
using System.Collections;
using System.Collections.Generic;
using DotNetify;
using UniversalDashboard.Execution;

namespace UniversalDashboard.Models
{
    public class ViewModel : BaseVM
    {
        private readonly IExecutionService _executionService;
        
        public Hashtable Members { get; set; }
        public string Name { get; set; }

        public ViewModel(string name, Hashtable members)
        {
            Name = name;
            Members = members;
        }

        internal ViewModel(IExecutionService executionService, Hashtable members)
        {
            _executionService = executionService;

            foreach (DictionaryEntry item in members)
            {
                if (item.Value is Endpoint endpoint)
                {
                    AddProperty(item.Key.ToString(), new Action(() => ExecuteEndpoint(endpoint)));
                }
                else
                {
                    AddProperty(item.Key.ToString(), item.Value);
                }
            }
        }

        private void ExecuteEndpoint(Endpoint endpoint)
        {
            var variables = new Dictionary<string, object>();
            var parameters = new Dictionary<string, object>();
            var executionContext = new ExecutionContext(endpoint, variables, parameters, null);
            executionContext.Variables.Add("this", this);
            _executionService.ExecuteEndpoint(executionContext, endpoint);
        }
    }
}
