using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDHtml")]
    public class NewHtmlCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewHtmlCommand));

		[Parameter(Mandatory = true, Position = 1)]
		public string Markup { get; set; }

		protected override void BeginProcessing()
		{
			var html = new RawHtml
			{
				Markup = Markup
			};

			Log.Debug(JsonConvert.SerializeObject(html));

			WriteObject(html);
		}
	}
}
