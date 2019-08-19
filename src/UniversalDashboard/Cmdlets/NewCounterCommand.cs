using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using UniversalDashboard.Models.Enums;
using System.Collections;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDCounter")]
    public class NewCounterCommand : CallbackCmdlet
    {
		private static readonly Logger Log = LogManager.GetLogger(nameof(NewCounterCommand));

		[Parameter]
		public string Title { get; set; }
		[Parameter]
		public string Format { get; set; } = "0,0";
		[Parameter]
		public FontAwesomeIcons Icon { get; set; }
		[Parameter]
		public DashboardColor BackgroundColor { get; set; }
		[Parameter]
		public DashboardColor FontColor { get; set; }
	    [Parameter]
	    public Hashtable[] Links { get; set; }
		[Parameter()]
		public TextSize TextSize { get; set; }

		[Parameter()]
		public TextAlignment TextAlignment { get; set; }
		
		[Parameter()]
		public ScriptBlock OnClick { get; set; }

		protected override void EndProcessing()
		{
			Endpoint onClick = null;
			if (OnClick != null)
			{
				onClick = GenerateCallback(Id + "onClick", OnClick, null);
			}

			var counter = new Counter
			{
				AutoRefresh = AutoRefresh,
				RefreshInterval = RefreshInterval,
				Callback = GenerateCallback(Id),
				OnClick = onClick,
				Format = Format,
				Icon = FontAwesomeIconsExtensions.GetIconName(Icon),
				Title = Title,
				Id = Id,
				BackgroundColor = BackgroundColor?.HtmlColor,
				FontColor = FontColor?.HtmlColor,
				Links = Links,
				TextAlignment = TextAlignment.GetName(),
				TextSize = TextSize.GetName(),
				HasOnClick = onClick != null
			};

			Log.Debug(JsonConvert.SerializeObject(counter));

			WriteObject(counter);
		}
	}
}
