using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
    public class DateTimeComponent : Component
    {
		[JsonProperty("dateTimeFormat")]
		public string DateTimeFormat { get; set; }

		[JsonProperty("value")]
		public string Value { get; set; }

		[JsonProperty("type")]
		public override string Type => "datetime";
    }
}
