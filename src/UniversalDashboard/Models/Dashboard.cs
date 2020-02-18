using System;
using System.Collections.Generic;
using System.Management.Automation.Runspaces;
using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
    public class Dashboard
    {
		[JsonProperty("id")]
		public Guid Id { get; set;}
		[JsonIgnore]
		public Theme[] Themes { get; set; }
        [JsonProperty("scripts")]
        public string[] Scripts { get; set; }
        [JsonProperty("stylesheets")]
        public string[] Stylesheets { get; set; }
        [JsonProperty("pages")]
        public List<Page> Pages { get; set; } = new List<Page>();
        [JsonProperty("cyclePages")]
        public bool CyclePages { get; set; }
        [JsonProperty("cyclePagesInterval")]
        public int CyclePagesInterval { get; set; }
        [JsonProperty("error")]
        public string Error { get; set; }
		[JsonIgnore]
		public InitialSessionState EndpointInitialSessionState { get; set; }
		public bool Demo { get; set; }
		[JsonProperty("geolocation")]
		public bool GeoLocation { get; set; }
        [JsonProperty("filterText")]
        public string FilterText { get; set; }
		[JsonIgnore]
		public TimeSpan IdleTimeout { get; set; }
    }
}
