using Newtonsoft.Json;

namespace UniversalDashboard.Models
{
    public class Monitor : Chart
    {
      [JsonProperty("chartBackgroundColor")]
      public new string[] ChartBackgroundColor { get; set; }
      [JsonProperty("chartBorderColor")]
      public new string[] ChartBorderColor { get; set; }

      [JsonProperty("type")]
      public new string Type => "Monitor";
    }
}
