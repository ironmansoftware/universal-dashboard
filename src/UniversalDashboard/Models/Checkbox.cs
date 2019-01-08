using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
    public class Checkbox : Component
    {
        [JsonProperty("checked")]
        public bool Checked { get; set; }

        [JsonProperty("color")]
        public string Color { get; set; }

        [JsonProperty("disabled")]
        public bool Disabled { get; set; }

        [JsonProperty("disableRipple")]
        public bool DisableRipple { get; set; }

        [JsonProperty("indeterminate")]
        public bool Indeterminate { get; set; }

        [JsonProperty("label")]
        public string Label { get; set; }

        [JsonIgnore]
        public Endpoint OnChanged { get; set; }

        [JsonProperty("type")]
        public override string Type => "muCheckbox";
    }
}
