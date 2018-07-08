using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
	public class Counter : Component
    {
		[JsonProperty("title")]
		public string Title { get; set; }
		[JsonProperty("icon")]
		public string Icon { get; set; }
		[JsonProperty("format")]
		public string Format { get; set; }
		[JsonProperty("backgroundColor")]
		public string BackgroundColor { get; set; }
		[JsonProperty("fontColor")]
		public string FontColor { get; set; }
		[JsonProperty("type")]
		public override string Type => "counter";
		[JsonProperty("links")]
		public Link[] Links { get;set;}
		[JsonProperty("textSize")]
		public string TextSize { get; set; }
		[JsonProperty("textAlignment")]
		public string TextAlignment { get; set; }
	}
}
