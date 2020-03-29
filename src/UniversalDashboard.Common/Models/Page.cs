﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace UniversalDashboard.Models
{
    public class Page : Component
    {
		[JsonProperty("type")]
		public override string Type => "page";

		[JsonProperty("name")]
		public string Name { get; set; }
		[JsonProperty("url")]
		public string Url { get; set; }

		[JsonProperty("defaultHomePage")]
		public Boolean DefaultHomePage { get; set; }
		[JsonProperty("icon")]
		public string Icon { get; set; }
		[JsonProperty("components")]
		public List<Component> Components { get; set; } = new List<Component>();

		[JsonProperty("dynamic")]
		public bool Dynamic { get; set; }

		[JsonProperty("title")]
		public string Title { get; set; }

		[JsonIgnore]
		public Dictionary<string, object> Properties { get; set; }

		[JsonProperty("blank")]
		public bool Blank { get; set; }
		[JsonProperty("onLoading")]
		public object Loading { get; set; }
    }
}
