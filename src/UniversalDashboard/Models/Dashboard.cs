using System;
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
		public string Title { get; set; }
		[JsonIgnore]
		public Theme[] Themes { get; set; }
		public string NavBarColor { get; set; }
	    public string NavBarFontColor { get; set; }
	    public string BackgroundColor { get; set; }
	    public string FontColor { get; set; }
	    public string FontIconStyle { get; set; }
		public IEnumerable<Link> NavbarLinks { get; set; }
		public string[] Scripts { get; set; }
		public string[] Stylesheets { get; set; }
	    public List<Page> Pages { get; set; } = new List<Page>();
		public bool CyclePages { get; set; }
		public int CyclePagesInterval { get; set; }
		public string Error { get; set; }
		public bool Design { get; set; }
		public Footer Footer { get; set; }
		public Element NavBarLogo { get; set; }
		[JsonIgnore]
		public InitialSessionState EndpointInitialSessionState { get; set; }
		public bool Demo { get; set; }
		[JsonProperty("geolocation")]
		public bool GeoLocation { get; set; }
		public string FilterText { get; set; }
		[JsonIgnore]
		public TimeSpan IdleTimeout { get; set; }
        [JsonProperty("navigation")]
        public SideNav Navigation { get; set; }
    }
}
