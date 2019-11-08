using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Models
{
    public abstract class Component
    {
		[JsonProperty("id")]
		public string Id { get; set; }
		[JsonIgnore]
		public Endpoint Callback { get; set; }
		[JsonProperty("refreshInterval")]
		public int RefreshInterval { get; set; }
		[JsonProperty("autoRefresh")]
		public bool AutoRefresh { get; set; }
		[JsonProperty("type")]
		public abstract string Type { get; }
		[JsonProperty("error", NullValueHandling = NullValueHandling.Ignore)]
		public Error Error { get; set; }

        [JsonProperty("hasCallback")]
        public bool HasCallback => Callback.HasCallback;

		public string ToJson() {
			return JsonConvert.SerializeObject(this);
		}
    }
    [JsonConverter(typeof(GenericComponentJsonConvert))]
    public class GenericComponent : Component
    {
        public GenericComponent(Dictionary<string, object> properties)
        {
            Type = properties["type"].ToString();
            Id = properties["id"].ToString();
            Properties = properties;
        }

		public GenericComponent(Hashtable properties) 
		{
            if (!properties.ContainsKey("type"))
            {
                throw new Exception("type is a required property");
            }

            if (!properties.ContainsKey("id"))
            {
                throw new Exception("id is a required property");
            }

            Type = properties["type"].ToString();
            Id = properties["id"].ToString();
            Properties = properties.ToDictionary() as Dictionary<string, object>;
		}

        public Dictionary<string, object> Properties { get; set; }

        public override string Type { get; }
    }
}
