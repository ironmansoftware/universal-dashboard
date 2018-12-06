using System.Collections;
using System.Collections.Generic;
using System.Management.Automation;
using Newtonsoft.Json;
using System.Linq;
using System;
using UniversalDashboard.Utilities;

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
        public Guid? JavaScriptId => JavaScriptPath?.ToGuid();
        [JsonProperty("componentName", NullValueHandling = NullValueHandling.Ignore)]
        public string ComponentName { get; set; }
        [JsonProperty("moduleName", NullValueHandling = NullValueHandling.Ignore)]
        public string ModuleName { get; set; }

        [JsonProperty("type")]
        public override string Type => "element";

        [JsonProperty("key")]
        public string Key
        {
            get
            {
                return Guid.NewGuid().ToString();
            }
        }

        [JsonProperty("onMount")]
        public string OnMount {get;set;}

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

        [JsonProperty("id")]
        public string Id => Callback?.Name;

        [JsonIgnore]
        public Endpoint Callback { get; set; }
        [JsonProperty("debounce")]
        public bool Debounce { get; set; }
        [JsonProperty("debounceTimeout")]
        public int DebounceTimeout { get; set; }
    }
}
