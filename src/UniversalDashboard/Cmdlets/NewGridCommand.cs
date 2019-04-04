using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System;
using System.Drawing;
using System.Linq;
using System.Management.Automation;
using System.Collections;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDGrid")]
    public class NewGridCommand : CallbackCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewGridCommand));

		[Parameter]
		public string Title { get; set; }
		[Parameter()]
		public string[] Headers { get; set; }
		[Parameter()]
		public string[] Properties { get; set; }


		[Parameter]
		public string DefaultSortColumn { get; set; }

		[Parameter]
		public SwitchParameter DefaultSortDescending { get; set; }
	    [Parameter]
	    public DashboardColor BackgroundColor { get; set; }
	    [Parameter]
	    public DashboardColor FontColor { get; set; }
	    [Parameter]
	    public Hashtable[] Links { get; set; }

		[Parameter]
		public SwitchParameter ServerSideProcessing { get; set; }
		[Parameter]
	    public string DateTimeFormat { get; set; } = "lll";

		[Parameter]
		public int PageSize { get; set; } = 10;

		[Parameter]
		public SwitchParameter NoPaging { get; set; }
		[Parameter]
	    public string FilterText { get; set; } = "Filter";

		protected override void EndProcessing()
		{
			if (NoPaging) {
				PageSize = Int32.MaxValue;
			}

			var grid = new Grid
			{
				Id = Id,
				Callback = GenerateCallback(Id),
				Headers = Headers,
				Properties = Properties,
				Title = Title,
				AutoRefresh = AutoRefresh,
				RefreshInterval = RefreshInterval,
				DefaultSortColumn = DefaultSortColumn,
				DefaultSortDescending = DefaultSortDescending,
				BackgroundColor = BackgroundColor?.HtmlColor,
				FontColor = FontColor?.HtmlColor,
				Links = Links,
				ServerSideProcessing = ServerSideProcessing,
				DateTimeFormat = DateTimeFormat,
				PageSize = PageSize,
				FilterText = FilterText
			};

			Log.Debug(JsonConvert.SerializeObject(grid));

			WriteObject(grid);
		}
	}
}
