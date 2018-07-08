using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
	public class Grid : Component
    {
		[JsonProperty("title")]
		public string Title { get; set; }
		[JsonProperty("headers")]
		public string[] Headers { get; set; }
		[JsonProperty("properties")]
		public string[] Properties { get; set; }
		[JsonProperty("defaultSortColumn")]
		public string DefaultSortColumn { get; set; }
		[JsonProperty("defaultSortDescending")]
		public bool DefaultSortDescending { get; set; }
		[JsonProperty("backgroundColor")]
		public string BackgroundColor { get; set; }
		[JsonProperty("fontColor")]
		public string FontColor { get; set; }
		[JsonProperty("type")]
		public override string Type => "grid";
		
		[JsonProperty("serverSideProcessing")]
		public bool ServerSideProcessing {get;set;}
		[JsonProperty("links")]
		public Link[] Links { get;set;}
		[JsonProperty("dateTimeFormat")]
		public string DateTimeFormat { get; set; }
		[JsonProperty("pageSize")]
		public int PageSize { get; set; }
		[JsonProperty("filterText")]
		public string FilterText { get; set; }
	}
}
