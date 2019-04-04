using System;
using UniversalDashboard.Models;
using System.Management.Automation;
using System.Linq;
using Newtonsoft.Json;
using NLog;
using System.Collections;

namespace UniversalDashboard.Cmdlets.Formatting
{
	[Cmdlet(VerbsCommon.New, "UDFooter")]
    public class NewFooterCommand : CallbackCmdlet
    {
		private static readonly Logger Log = LogManager.GetLogger(nameof(NewFooterCommand));

		[Parameter()]
		public Hashtable[] Links { get; set; }
        [Parameter()]
        public string Copyright {get;set;}
		[Parameter()]
		public DashboardColor BackgroundColor {get;set;}
		[Parameter()]
		public DashboardColor FontColor {get;set;}
		
		protected override void EndProcessing()
		{
			var footer = new Footer();

			footer.BackgroundColor = BackgroundColor?.HtmlColor;
			footer.FontColor = BackgroundColor?.HtmlColor;
			footer.Links = Links;
			footer.Copyright = Copyright;

			Log.Debug(JsonConvert.SerializeObject(footer));

			WriteObject(footer);
		}
	}
}
