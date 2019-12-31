using Newtonsoft.Json;
using System.Collections;
using System.Drawing;
using UniversalDashboard.Services;

namespace UniversalDashboard.Models
{
    public class Chart : Component
    {
		[JsonProperty("chartType")]
		public ChartType ChartType { get; set; }
		[JsonProperty("labels")]
		public string[] Labels { get; set; }
		[JsonProperty("title")]
		public string Title { get; set; }
		[JsonProperty("options")]
		public Hashtable Options { get; set; }
		[JsonProperty("width")]
		public string Width { get; set; }
		[JsonProperty("height")]
		public string Height { get; set; }
		[JsonProperty("live")]
		public bool Live { get; set; }
		[JsonProperty("dataPointRetention")]
		public int DataPointRetention { get; set; }
		[JsonProperty("chartBackgroundColor")]
		public string ChartBackgroundColor { get; set; }
		[JsonProperty("chartBorderColor")]
		public string ChartBorderColor { get; set; }
		[JsonProperty("backgroundColor")]
		public string BackgroundColor { get; set; }
		[JsonProperty("fontColor")]
		public string FontColor { get; set; }
		[JsonProperty("borderWidth")]
		public int BorderWidth { get; set; }
		[JsonProperty("type")]
		public override string Type => "ud-chart";
		[JsonProperty("links")]
		public Hashtable[] Links { get;set;}
		[JsonProperty("filterFields")]
		public Field[] FilterFields { get; set; }
		[JsonIgnore]
		public Endpoint OnClick {get;set;}
        [JsonProperty("clickable")]
        public bool Clickable { get; set; }

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

	public enum ChartType
	{
		Bar,
		Line,
		Area,
		Doughnut,
		Radar,
		Pie,
        HorizontalBar
	}
}
