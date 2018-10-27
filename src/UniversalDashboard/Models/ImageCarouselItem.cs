using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using System.Threading.Tasks;

namespace UniversalDashboard.Models
{
    public class ImageCarouselItem : Component
    {
		[JsonProperty("backgroundColor")]
		public string BackgroundColor { get; set; }
		[JsonProperty("backgroundImage")]
		public string BackgroundImage { get; set; }
		[JsonProperty("backgroundRepeat")]
		public string BackgroundRepeat { get; set; }
		[JsonProperty("backgroundSize")]
		public string BackgroundSize { get; set; }
		[JsonProperty("backgroundPosition")]
		public string BackgroundPosition { get; set; }
		[JsonProperty("fontColor")]
		public string FontColor { get; set; }
		[JsonProperty("title")]
		public string Title { get; set; }
		[JsonProperty("titlePosition")]
		public string TitlePosition { get; set; }
		[JsonProperty("textPosition")]
		public string TextPosition { get; set; }
		[JsonProperty("url")]
		public string Url { get; set; }
		[JsonProperty("text")]
		public string Text { get; set; }
		public override string Type => "imageCarouselItem";
	}
}