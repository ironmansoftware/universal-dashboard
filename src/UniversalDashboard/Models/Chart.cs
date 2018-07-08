using Newtonsoft.Json;
using System.Collections;
using System.Drawing;

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
		public override string Type => "chart";
		[JsonProperty("links")]
		public Link[] Links { get;set;}
		[JsonProperty("filterFields")]
		public Field[] FilterFields { get; set; }
	}

	public enum ChartType
	{
		Bar,
		Line,
		Area,
		Doughnut,
		Radar,
		Pie
	}
}
