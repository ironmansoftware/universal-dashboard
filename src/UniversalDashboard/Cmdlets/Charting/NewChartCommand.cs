using System.Management.Automation;
using UniversalDashboard.Models;
using System.Collections;
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
		public string Width { get; set; }
		[Parameter]
		public string Height { get; set; }

		[Parameter]
		public DashboardColor BackgroundColor { get; set; }
		[Parameter]
		public DashboardColor FontColor { get; set; }
		[Parameter]
		public Link[] Links { get; set; }
		[Parameter]

		public ScriptBlock FilterFields { get; set; }
		
		[Parameter]
		public object OnClick {get;set;}

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
				Width = Width,
				Height = Height,
				AutoRefresh = AutoRefresh,
				RefreshInterval = RefreshInterval,
				BackgroundColor = BackgroundColor?.HtmlColor,
				FontColor = FontColor?.HtmlColor,
				Links = Links,
				FilterFields = FilterFields?.Invoke().Select(m => m.BaseObject).OfType<Field>().ToArray()
			};

			Endpoint callback = null;

			var scriptBlock = OnClick as ScriptBlock;
			if (scriptBlock != null)
			{
				callback = GenerateCallback(Id + "onClick", scriptBlock, null);
			}
			else
			{
				var psobject = OnClick as PSObject;
				callback = psobject?.BaseObject as Endpoint;
			}

            chart.Clickable = callback != null;
            Log.Debug(JsonConvert.SerializeObject(chart));

			WriteObject(chart);
		}
	}
}
