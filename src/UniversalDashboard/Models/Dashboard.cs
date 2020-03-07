using System;
using System.Collections;
using System.Collections.Generic;
using System.Management.Automation.Runspaces;
using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
	public class Dashboard
    {
		[JsonProperty("id")]
		public Guid Id { get; set;}
        [JsonProperty("title")]
        public string Title { get; set; }
		[JsonProperty("theme")]
		public Theme Theme { get; set; }
        [JsonProperty("scripts")]
        public string[] Scripts { get; set; }
        [JsonProperty("stylesheets")]
        public string[] Stylesheets { get; set; }
        [JsonProperty("pages")]
        public List<Page> Pages { get; set; } = new List<Page>();
        [JsonProperty("error")]
        public string Error { get; set; }
		[JsonIgnore]
		public InitialSessionState EndpointInitialSessionState { get; set; }
		public bool Demo { get; set; }
		[JsonProperty("geolocation")]
		public bool GeoLocation { get; set; }
		[JsonIgnore]
		public TimeSpan IdleTimeout { get; set; }
        [JsonProperty("frameworkAssetId")]
        public string FrameworkAssetId { get; set; }
        [JsonIgnore]
        public Dictionary<string, object> Properties { get; set; }
    }
}
