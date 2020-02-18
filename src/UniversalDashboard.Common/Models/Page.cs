using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace UniversalDashboard.Models
{
    public class Page : Component
    {
		[JsonProperty("type")]
		public override string Type => "ud-page";
		[JsonProperty("url")]
		public string Url { get; set; }
		[JsonProperty("components")]
		public List<Component> Components { get; set; } = new List<Component>();
    }
}
