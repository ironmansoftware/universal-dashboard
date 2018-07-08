using System.Management.Automation;
using UniversalDashboard.Models;
using System.Collections;
using System.Drawing;
using Newtonsoft.Json;
using NLog;
using System.Linq;

namespace UniversalDashboard.Cmdlets.Charting
{
	[Cmdlet(VerbsCommon.New, "UDChart")]
	public class NewChartCommand : CallbackCmdlet
	{
		private readonly Logger Log = LogManager.GetLogger(nameof(NewChartCommand));

		[Parameter]
		public string[] Labels { get; set; }
		[Parameter]
		public ChartType Type { get; set; }
		[Parameter]
		public string Title { get; set; }
		[Parameter]
		public Hashtable Options { get; set; }

		[Parameter]
		public DashboardColor BackgroundColor { get; set; }
		[Parameter]
		public DashboardColor FontColor { get; set; }
		[Parameter]
		public Link[] Links { get; set; }
		[Parameter]

		public ScriptBlock FilterFields { get; set; }

		protected override void EndProcessing()
		{
			var chart = new Chart
			{
				Id = Id,
				Labels = Labels,
				Title = Title,
				ChartType = Type,
				Callback = GenerateCallback(Id),
				Options = Options,
				AutoRefresh = AutoRefresh,
				RefreshInterval = RefreshInterval,
				BackgroundColor = BackgroundColor?.HtmlColor,
				FontColor = FontColor?.HtmlColor,
				Links = Links,
				FilterFields = FilterFields?.Invoke().Select(m => m.BaseObject).OfType<Field>().ToArray()
			};

			Log.Debug(JsonConvert.SerializeObject(chart));

			WriteObject(chart);
		}
	}
}
