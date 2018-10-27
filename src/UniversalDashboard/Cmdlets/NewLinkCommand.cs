using System;
using System.Management.Automation;
using UniversalDashboard.Models;
using Newtonsoft.Json;
using NLog;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDLink")]
    public class NewLinkCommand : PSCmdlet 
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewLinkCommand));

		[Parameter()]
		public string Text { get; set; }
	    [Parameter(Mandatory = true)]
		public string Url { get; set; }
		[Parameter()]
		public FontAwesomeIcons Icon { get; set; }

		[Parameter()]
		public SwitchParameter OpenInNewWindow { get; set; }

		[Parameter()]
		public DashboardColor FontColor { get; set; }

	    protected override void EndProcessing()
	    {
			var iconString = Enum.GetName(typeof(FontAwesomeIcons), Icon).TrimStart('_').Replace("_", "-");

			var link = new Link
		    {
			    text = Text,
				url = Url,
				icon = iconString,
				openInNewWindow = OpenInNewWindow,
				Color = FontColor?.HtmlColor
			};

			Log.Debug(JsonConvert.SerializeObject(link));

			WriteObject(link);

		}
    }
}
