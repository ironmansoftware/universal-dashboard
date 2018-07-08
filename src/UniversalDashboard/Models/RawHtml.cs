using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
	public class RawHtml : Component
    {
		[JsonProperty("markup")]
		public string Markup { get; set; }
		[JsonProperty("type")]
		public override string Type => "rawHtml";
	}
}
