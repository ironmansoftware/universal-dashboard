using System.Collections;
using Newtonsoft.Json;
using UniversalDashboard.Services;

namespace UniversalDashboard.Models
{
	public class Footer : Component
    {
		[JsonProperty("links")]
		public Hashtable[] Links { get; set; }
        
        [JsonProperty("copyright")]
        public string Copyright {get;set;}
        
        [JsonProperty("backgroundColor")]
        public string BackgroundColor {get;set;}
        
        [JsonProperty("fontColor")]
        public string FontColor {get;set;}

        [JsonProperty("type")]
        public override string Type => "ud-footer";

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
