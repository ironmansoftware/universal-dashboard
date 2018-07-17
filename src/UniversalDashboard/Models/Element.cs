using System.Collections;
using System.Collections.Generic;
using System.Management.Automation;
using Newtonsoft.Json;
using System.Linq;

namespace UniversalDashboard.Models.Basics
{
	public class Element : Component
    {
        [JsonProperty("tag", NullValueHandling = NullValueHandling.Ignore)]
        public string Tag { get; set; }
        [JsonProperty("attributes", NullValueHandling = NullValueHandling.Ignore)]
        public Hashtable Attributes { get; set; }
        [JsonProperty("props", NullValueHandling = NullValueHandling.Ignore)]
        public Hashtable Properties { get; set; }
        [JsonProperty("events", NullValueHandling = NullValueHandling.Ignore)]
        public ElementEventHandler[] Events { get; set; }
        [JsonProperty("content", NullValueHandling = NullValueHandling.Ignore)]
		public object[] Content { get; set; }
        [JsonIgnore]
		public string JavaScriptPath { get; set; }
        [JsonProperty("js", NullValueHandling = NullValueHandling.Ignore)]
        public int? JavaScriptId => JavaScriptPath?.GetHashCode();
        [JsonProperty("componentName", NullValueHandling = NullValueHandling.Ignore)]
        public string ComponentName { get; set; }
        [JsonProperty("moduleName", NullValueHandling = NullValueHandling.Ignore)]
        public string ModuleName { get; set; }

        [JsonProperty("type")]
        public override string Type => "element";

        public override string ToString()
        {
            if (string.IsNullOrEmpty(Tag))
            {
                return string.Empty;
            }

            return $"<{Tag} id={Id}></{Tag}>";
        }
    }

    public class ElementEventHandler {
        [JsonProperty("event")]
        public string Event { get; set; }
        [JsonIgnore]
        public Endpoint Callback { get; set; }
        [JsonProperty("debounce")]
        public bool Debounce { get; set; }
        [JsonProperty("debounceTimeout")]
        public int DebounceTimeout { get; set; }
    }
}
