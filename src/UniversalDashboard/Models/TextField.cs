using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
    public class TextField : Component
    {
        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("placeholder")]
        public string Placeholder { get; set; }

        [JsonProperty("type")]
        public override string Type => "muTextField";
    }
}
