using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
    public class Error : Component
    {
		[JsonProperty("message")]
		public string Message { get; set; }

		[JsonProperty("location")]
		public string Location { get; set; }

		[JsonProperty("type")]
		public override string Type => "error";
    }
}
