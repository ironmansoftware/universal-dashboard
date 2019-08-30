using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
    public class SideNav : Component
    {
        [JsonProperty("content")]
        public SideNavItem[] Content { get; set; }

        [JsonProperty("none")]
        public bool None { get; set; }

        [JsonProperty("fixed")]
        public bool Fixed { get; set; }

        [JsonProperty("width")]
        public int Width { get; set; }

        [JsonProperty("type")]
        public override string Type => "side-nav";
    }

    public class SideNavItem : Component
    {
        [JsonProperty("divider")]
        public bool Divider { get; set; }

        [JsonProperty("subheader")]
        public bool SubHeader { get; set; }

        [JsonProperty("icon")]
        public string Icon { get; set; }

        [JsonProperty("image")]
        public string Image { get; set; }

        [JsonProperty("background")]
        public string Background { get; set; }

        [JsonProperty("text")]
        public string Text { get; set; }

        [JsonProperty("url")]
        public string Url { get; set; }

        [JsonProperty("children")]
        public SideNavItem[] Children { get; set; }

        public override string Type => "side-nav-item";
    }
}
