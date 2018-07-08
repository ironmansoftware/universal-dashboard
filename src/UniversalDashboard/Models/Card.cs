using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
	public class Card : Component
	{
		[JsonProperty("type")]
		public override string Type => "card";
		[JsonProperty("title")]
		public string Title { get; set; }
		[JsonProperty("text")]
		public string Text { get; set; }
		[JsonProperty("links")]
		public Link[] Links { get;set;}
		[JsonProperty("backgroundColor")]
		public string BackgroundColor { get; set; }
		[JsonProperty("fontColor")]
		public string FontColor { get; set; }
		[JsonProperty("language")]
		public string Language {get;set;}
		[JsonProperty("icon")]
		public string Icon { get; set; }
		[JsonProperty("textSize")]
		public string TextSize { get; set; }
		[JsonProperty("textAlignment")]
		public string TextAlignment { get; set; }
		[JsonProperty("content")]
		public object[] Content { get; set; }
	}
}
