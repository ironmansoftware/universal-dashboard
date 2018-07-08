using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using UniversalDashboard.Models.Enums;
using System.Linq;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDCard", DefaultParameterSetName = "text")]
    public class NewCardCommand : ComponentCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewCardCommand));

		[Parameter(Position = 0)]
		public string Title { get; set; }
		[Parameter(Position = 1, ParameterSetName = "text")]
		public string Text { get; set; }
		[Parameter(Position = 2)]
		public Link[] Links { get; set; }
		[Parameter(Position = 3)]
		public DashboardColor BackgroundColor { get; set; }
		[Parameter(Position = 4)]
		public DashboardColor FontColor { get; set; }
		[Parameter(Position = 5)]
		public FontAwesomeIcons Watermark { get; set; }
		[Parameter(Position = 6, ParameterSetName = "text")]
		public TextSize TextSize { get; set; }

		[Parameter(Position = 7, ParameterSetName = "text")]
		public TextAlignment TextAlignment { get; set; }

		[Parameter()]
		public string Language {get;set;}

		[Parameter(ParameterSetName = "content")]
		public ScriptBlock Content { get; set; }

		protected override void EndProcessing()
		{
			var card = new Card
			{
				Title = Title,
				Text = Text,
				Links = Links,
				Id = Id,
				Language = Language,
				FontColor = FontColor?.HtmlColor,
				BackgroundColor = BackgroundColor?.HtmlColor,
				Icon = Watermark.GetIconName(),
				TextAlignment = TextAlignment.GetName(),
				TextSize = TextSize.GetName(),
				Content = Content?.Invoke().Select(m => m?.BaseObject).ToArray()
			};

			Log.Debug(JsonConvert.SerializeObject(card));

			WriteObject(card);
		}
	}
}
