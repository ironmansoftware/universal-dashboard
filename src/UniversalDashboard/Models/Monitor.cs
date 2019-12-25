using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
    public class Monitor : Chart
    {
      [JsonProperty("chartBackgroundColor")]
      public new string[] ChartBackgroundColor { get; set; }
      [JsonProperty("chartBorderColor")]
      public new string[] ChartBorderColor { get; set; }
      [JsonProperty("width")]
      public new string Width { get; set; }
      [JsonProperty("height")]
      public new string Height { get; set; }

      [JsonProperty("type")]
      public new string Type => "ud-monitor";
    }
}
