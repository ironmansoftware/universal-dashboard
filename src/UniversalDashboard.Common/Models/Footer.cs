using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
	public class Footer : Component
    {
		[JsonProperty("links")]
		public Link[] Links { get; set; }
        [JsonProperty("copyright")]
        public string Copyright {get;set;}
        [JsonProperty("title")]
        public string BackgroundColor {get;set;}
        [JsonProperty("fontColor")]
        public string FontColor {get;set;}

        [JsonProperty("type")]
        public override string Type => "footer";
    }
}
