using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
	public class Input : Component
	{
		[JsonProperty("type")]
		public override string Type => "input";

		[JsonProperty("title")]
		public string Title { get; set; }

		[JsonProperty("submitText")]
		public string SubmitText { get; set; }

		[JsonProperty("fields")]
		public Field[] Fields { get; set; }

		[JsonProperty("backgroundColor")]
		public string BackgroundColor { get; set; }
		[JsonProperty("fontColor")]
		public string FontColor { get; set; }
	}

	public class Field
	{
		[JsonProperty("required")]
		public bool Required { get; set; }

		[JsonProperty("type")]
		public string Type { get; set; }

		[JsonProperty("dotNetType")]
		public string DotNetType { get; set; }

		[JsonProperty("validOptions")]
		public object[] ValidOptions { get; set; }
		[JsonProperty("placeholder")]
		public string[] Placeholder { get; set; }

		[JsonProperty("name")]
		public string Name { get; set; }

		[JsonProperty("value")]
		public object Value { get; set; }
		[JsonProperty("links")]
		public Link[] Links { get;set;}
        [JsonProperty("okText")]
        public string OkText { get; set; }
        [JsonProperty("cancelText")]
        public string CancelText { get; set; }
        [JsonProperty("clearText")]
        public string ClearText { get; set; }
    }

	public static class FieldTypes
	{
		public static string Checkbox = "checkbox";
		public static string Textbox = "textbox";
		public static string Select = "select";
		public static string RadioButtons = "radioButtons";
        public static string Date = "date";
        public static string Time = "time";
    }
}

