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
		public override string Type => "treeview";

		[JsonProperty("node")]
		public TreeNode Node { get; set; }
    }
}
