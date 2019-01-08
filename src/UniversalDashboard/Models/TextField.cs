using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
    public class TextField : Component
    {
        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("placeholder")]
        public string Placeholder { get; set; }

        [JsonProperty("autoFocus")]
        public bool AutoFocus { get; set; }

        [JsonProperty("defaultValue")]
        public string DefaultValue { get; set; }

        [JsonProperty("disabled")]
        public bool Disabled { get; set; }

        [JsonProperty("error")]
        public new bool Error { get; set; }

        [JsonProperty("fullWidth")]
        public bool FullWidth { get; set; }

        [JsonProperty("multiLine")]
        public bool MultiLine { get; set; }

        [JsonProperty("required")]
        public bool Required { get; set; }

        [JsonProperty("rows")]
        public int Rows { get; set; }

        [JsonProperty("rowsMax")]
        public int RowsMax { get; set; }

        [JsonProperty("helperText")]
        public string HelperText { get; set; }

        [JsonProperty("value")]
        public string Value { get; set; }

        [JsonProperty("variant")]
        public string Variant { get; set; }

        [JsonProperty("type")]
        public override string Type => "muTextField";
    }
}
