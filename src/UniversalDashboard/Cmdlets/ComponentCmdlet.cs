using System;
using System.Collections;
using System.Collections.ObjectModel;
using System.Linq;
using System.Management.Automation;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Cmdlets
{
    public class ComponentCmdlet : PSCmdlet
    {
		[Parameter]
		public string Id { get; set; } = Guid.NewGuid().ToString();

        internal IDashboardService DashboardService
        {
            get
            {
                return SessionState.PSVariable.Get(Constants.DashboardService)?.Value as IDashboardService;
            }
        }

        internal string SessionId
        {
            get
            {
                return SessionState.PSVariable.Get(Constants.SessionId)?.Value as string;
            }
        }
    }

    public class BindableComponentCmdlet : ComponentCmdlet, IDynamicParameters
    {
        protected ViewModelBinding GetViewModelBinding()
        {
            var hashtable = new Hashtable();
            foreach (var boundParameter in MyInvocation.BoundParameters)
            {
                if (boundParameter.Key.EndsWith("Binding"))
                {
                    var key = boundParameter.Key.Replace("Binding", string.Empty);

                    var endpoint = GetType().GetProperty(key).GetCustomAttributes(typeof(EndpointAttribute), false).Any();
                    key = char.ToLowerInvariant(key[0]) + key.Substring(1);

                    if (endpoint)
                    {
                        key += "_endpoint";
                    }

                    hashtable.Add(key, boundParameter.Value);
                }
            }

            if (hashtable.Count > 0)
            {
                return new ViewModelBinding("root", hashtable);
            }

            return null;
        }


        public object GetDynamicParameters()
        {
            var parameters = GetType().GetProperties().Where(m => m.GetCustomAttributes(typeof(ParameterAttribute), false).Any());

            var parameterDictionary = new RuntimeDefinedParameterDictionary();
            foreach (var parameter in parameters)
            {
                var bindingParameter = new ParameterAttribute();
                var attributeCollection = new Collection<Attribute>();
                attributeCollection.Add(bindingParameter);
                var runtimeDefinedParameter = new RuntimeDefinedParameter(parameter.Name + "Binding", typeof(string), attributeCollection);
                parameterDictionary.Add(parameter.Name + "Binding", runtimeDefinedParameter);
            }

            return parameterDictionary;
        }
    }

	public class ColoredComponentCmdlet : ComponentCmdlet {
		[Parameter]
		public DashboardColor BackgroundColor { get; set; }
		
		[Parameter]
		public DashboardColor FontColor { get; set; }
		
	}
}
