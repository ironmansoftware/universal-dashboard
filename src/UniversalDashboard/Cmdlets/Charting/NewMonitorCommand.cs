using System.Collections;
using System.Drawing;
using System.Management.Automation;
using Newtonsoft.Json;
using UniversalDashboard.Models;
using NLog;
using System.Linq;

namespace UniversalDashboard.Cmdlets.Charting
{
	[Cmdlet(VerbsCommon.New, "UDMonitor")]
	public class NewMonitorCommand : CallbackCmdlet
	{
		private readonly Logger Log = LogManager.GetLogger(nameof(NewMonitorCommand));

		public NewMonitorCommand()
		{
			AutoRefresh = true;
			RefreshInterval = 5;
			ChartBackgroundColor = new [] {new DashboardColor(Color.FromArgb(128, 47, 125, 188)) };
			ChartBorderColor = new [] {new DashboardColor(Color.FromArgb(47, 125, 188))};
		}

		[Parameter]
		public ChartType Type { get; set; }
		[Parameter(Mandatory = true)]
		public string Title { get; set; }
		[Parameter]
		public int DataPointHistory { get; set; } = 10;
		[Parameter]
		public Hashtable Options { get; set; }

		[Parameter]
		public DashboardColor[] ChartBackgroundColor { get; set; }
		[Parameter]
		public DashboardColor[] ChartBorderColor { get; set; }

		[Parameter]
		public DashboardColor BackgroundColor { get; set; }
		[Parameter]
		public DashboardColor FontColor { get; set; }
		[Parameter]
		public int BorderWidth { get; set; } = 1;
		[Parameter]
		public string[] Label { get;set;}
		[Parameter]
		public Link[] Links {get;set;}
		[Parameter]
		public ScriptBlock FilterFields { get; set; }
		protected override void EndProcessing()
		{
			var monitor = new Monitor
			{
				Id = Id,
				Title = Title,
				ChartType = Type,
				Callback = GenerateCallback(Id),
				Options = Options,
				Live = true,
				Labels = Label != null ? Label : new [] {Title},
				ChartBorderColor = ChartBorderColor?.Select(m => m.HtmlColor).ToArray(),
				BorderWidth = BorderWidth,
				ChartBackgroundColor = ChartBackgroundColor?.Select(m => m.HtmlColor).ToArray(),
				BackgroundColor = BackgroundColor?.HtmlColor,
				FontColor = FontColor?.HtmlColor,
				DataPointRetention = DataPointHistory,
				RefreshInterval = RefreshInterval,
				AutoRefresh = AutoRefresh,
				Links = Links,
				FilterFields = FilterFields?.Invoke().Select(m => m.BaseObject).OfType<Field>().ToArray()
			};

			Log.Debug(JsonConvert.SerializeObject(monitor));

			WriteObject(monitor);
		}
	}
}
