using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
	public class Theme
	{
		[JsonProperty("name")]
		public string Name { get; set; }
		[JsonProperty("definition")]
		public Hashtable Definition { get; set; }
		[JsonProperty("parent")]
		public string Parent { get; set; }
		[JsonIgnore]
		public string RenderedContent { get; set; }
	}
}
