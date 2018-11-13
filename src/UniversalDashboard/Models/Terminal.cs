using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
	public class Terminal : Component
    {
		[JsonProperty("type")]
		public override string Type => "terminal";
	}
}
