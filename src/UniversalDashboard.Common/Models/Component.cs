using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
    public abstract class Component
    {
		[JsonProperty("id")]
		public string Id { get; set; }
		[JsonIgnore]
		public Endpoint Callback { get; set; }
		[JsonProperty("refreshInterval")]
		public int RefreshInterval { get; set; }
		[JsonProperty("autoRefresh")]
		public bool AutoRefresh { get; set; }
		[JsonProperty("type")]
		public abstract string Type { get; }
		[JsonProperty("error", NullValueHandling = NullValueHandling.Ignore)]
		public Error Error { get; set; }

		[JsonProperty("hasCallback")]
		public bool HasCallback => Callback?.ScriptBlock != null;

		public string ToJson() {
			return JsonConvert.SerializeObject(this);
		}
    }
}
