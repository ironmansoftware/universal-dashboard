using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UniversalDashboard.Services;

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

		//TODO: This is temporary and we should eventually move this into a ps1 file.
		[JsonProperty("assetId")]
		public string AssetId {
			get 
			{
				if (AssetService.Instance.Frameworks.ContainsKey("Materialize"))
				{
					return AssetService.Instance.Frameworks["Materialize"];
				}

				return null;
			}
		}

		[JsonProperty("isPlugin")]
		public bool IsPlugin => true;
    }
}
