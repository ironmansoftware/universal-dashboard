using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
	public class Link
    {
		[JsonProperty("text")]
		public string text { get; set; }
		[JsonProperty("url")]
		public string url { get; set; }
		[JsonProperty("icon")]
		public string icon { get; set; }

		[JsonProperty("openInNewWindow")]
		public bool openInNewWindow { get; set; }

		[JsonProperty("type")]
		public string type => "link";

		[JsonProperty("color")]
		public string Color { get; set; }
    }
}
