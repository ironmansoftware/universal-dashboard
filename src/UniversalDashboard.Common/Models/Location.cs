using System;
using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
	public class Location
    {
        [JsonProperty("coords")]
		public Coords Coords { get; set; }

        [JsonProperty("timestamp")]
        public DateTime Timestamp { get; set; }
    }

    public class Coords {
        [JsonProperty("latitude")]
		public decimal? Latitude { get; set; }
		[JsonProperty("longitude")]
		public decimal? Longitude { get; set; }
        [JsonProperty("accuracy")]
		public int? Accuracy { get; set; }
        [JsonProperty("altitude")]
		public decimal? Altitude { get; set; }
        [JsonProperty("altitudeAccuracy")]
		public int? AltitudeAccuracy { get; set; }
        [JsonProperty("heading")]
		public decimal? Heading { get; set; }
        [JsonProperty("speed")]
		public decimal? Speed { get; set; }

    }
}
