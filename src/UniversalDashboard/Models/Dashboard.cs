using System;
using System.Collections;
using System.Collections.Generic;
using System.Management.Automation.Runspaces;
using Newtonsoft.Json;
using UniversalDashboard.Models.Basics;

namespace UniversalDashboard.Models
{
	public class Dashboard
    {
		[JsonProperty("id")]
		public Guid Id { get; set;}
        [JsonProperty("title")]
        public string Title { get; set; }
		[JsonProperty("themes")]
		public Theme[] Themes { get; set; }
        [JsonProperty("navBarColor")]
        public string NavBarColor { get; set; }
        [JsonProperty("navBarFontColor")]
        public string NavBarFontColor { get; set; }
        [JsonProperty("backgroundColor")]
        public string BackgroundColor { get; set; }
        [JsonProperty("fontColor")]
        public string FontColor { get; set; }
        [JsonProperty("navbarLinks")]
        public IEnumerable<Hashtable> NavbarLinks { get; set; }
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
        [JsonProperty("footer")]
        public Footer Footer { get; set; }
        [JsonProperty("navBarLogo")]
        public Element NavBarLogo { get; set; }
		[JsonIgnore]
		public InitialSessionState EndpointInitialSessionState { get; set; }
		public bool Demo { get; set; }
		[JsonProperty("geolocation")]
		public bool GeoLocation { get; set; }
        [JsonProperty("filterText")]
        public string FilterText { get; set; }
		[JsonIgnore]
		public TimeSpan IdleTimeout { get; set; }
        [JsonProperty("navigation")]
        public SideNav Navigation { get; set; }
        [JsonProperty("frameworkAssetId")]
        public string FrameworkAssetId { get; set; }
        [JsonIgnore]
        public Dictionary<string, object> Properties { get; set; }
    }
}
