using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
    public class Chip : Component
    {
        [JsonProperty("label")]
        public string Label { get; set; }

        [JsonProperty("icon")]
        public string Icon { get; set; }

        [JsonIgnore]
        public Endpoint OnDelete { get; set; }

        [JsonIgnore]
        public Endpoint OnClick { get; set; }

        [JsonProperty("chipStyle")]
        public string Style { get; set; }

        [JsonProperty("color")]
        public string Color { get; set; }

        [JsonProperty("clickable")]
        public bool Clickable { get; set; }

        [JsonProperty("delete")]
        public bool Delete { get; set; }
        [JsonProperty("avatar")]
        public string Avatar { get; set; }

        [JsonProperty("avatarType")]
        public string AvatarType { get; set; }

        [JsonProperty("type")]
        public override string Type => "muChip";

    }
}