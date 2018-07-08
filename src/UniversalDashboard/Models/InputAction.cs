using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
	public class InputAction
    {
		public static string Toast => "toast";
	    public static string Redirect => "redirect";
		public static string Content => "content";

		[JsonProperty("type")]
		public string Type { get; set; }

		[JsonProperty("duration")]
		public int Duration { get; set; }

	    [JsonProperty("text")]
		public string Text { get; set; }

		[JsonProperty("route")]
		public string Route { get; set; }

		[JsonProperty("components")]
		public Component[] Components { get; set; }

		[JsonProperty("clearInput")]
		public bool ClearInput { get; set; }

    }
}

