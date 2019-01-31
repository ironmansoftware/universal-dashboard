using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.Collections;
using System.Management.Automation;
using UniversalDashboard.Models;

namespace UniversalDashboard.Utilities
{
    public class CustomContractResolver : DefaultContractResolver
    {
        protected override JsonConverter ResolveContractConverter(Type objectType)
        {
            if (objectType.IsAssignableFrom(typeof(GenericComponent)))
            {
                return new GenericComponentJsonConvert();
            }

            if (typeof(PSObject).IsAssignableFrom(objectType) || typeof(Hashtable).IsAssignableFrom(objectType))
            {
                return new PSObjectJsonConvert();
            }

            return base.ResolveContractConverter(objectType);
        }

        //protected override JsonObjectContract CreateObjectContract(Type objectType)
        //{
        //    JsonObjectContract contract = base.CreateObjectContract(objectType);
        //    if (objectType.IsAssignableFrom(typeof(GenericComponent)))
        //    {
        //        contract.Converter = new GenericComponentJsonConvert();
        //    }

        //    if (typeof(PSObject).IsAssignableFrom(objectType) || typeof(Hashtable).IsAssignableFrom(objectType))
        //    {
        //        contract.Converter = new PSObjectJsonConvert();
        //    }

        //    return contract;
        //}

        protected override string ResolvePropertyName(string propertyName)
        {
            propertyName = base.ResolvePropertyName(propertyName);
            return char.ToLowerInvariant(propertyName[0]) + propertyName.Substring(1);
        }
    }
}
