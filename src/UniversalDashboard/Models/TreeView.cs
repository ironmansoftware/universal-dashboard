using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace UniversalDashboard.Models
{
    public class TreeView : Component
    {
			[JsonProperty("type")]
			public override string Type => "ud-treeview";

			[JsonProperty("node")]
			public TreeNode Node { get; set; }

			[JsonProperty("backgroundColor")]
			public string BackgroundColor { get; set; }

			[JsonProperty("fontColor")]
			public string FontColor { get; set; }
			[JsonProperty("activeBackgroundColor")]
			public string ActiveBackgroundColor { get; set; }
			[JsonProperty("toggleColor")]
			public string ToggleColor { get; set; }
    }
}
