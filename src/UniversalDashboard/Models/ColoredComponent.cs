using Newtonsoft.Json;
using System.Collections.Generic;

namespace UniversalDashboard.Models
{
	public abstract class ColoredComponent : Component
    {
        [JsonProperty("backgroundColor")]
		public string BackgroundColor { get; set; }
        [JsonProperty("fontColor")]
        public string FontColor { get; set; }
    }
}
