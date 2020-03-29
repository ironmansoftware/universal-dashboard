using System;
using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using System.Collections.Generic;
using System.Collections;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDPage")]
    public class NewPageCommand : PSCmdlet, IDynamicParameters
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewPageCommand));

		[Parameter(Position = 0, Mandatory = true)]
		public string Name { get; set; }
	    [Parameter(Position = 1)]
		public FontAwesomeIcons Icon { get; set; }
	    [Parameter(Position = 2)]
		[Alias("Endpoint")]
		public ScriptBlock Content { get; set; }
		[Parameter(Position = 0)]
		public string Url { get; set; }

		[Parameter(Position = 3)]
		public SwitchParameter DefaultHomePage { get; set; }

		[Parameter(Position = 4)]
		public string Title { get; set; }

		[Parameter]
		public SwitchParameter Blank { get; set; }

        [Parameter]
        public object[] ArgumentList { get; set; }

        [Parameter]
	    public SwitchParameter AutoRefresh { get; set; }

	    [Parameter]
	    public int RefreshInterval { get; set; } = 5;
		
		[Parameter]
		public string Id { get; set; } = Guid.NewGuid().ToString();
		
		[Parameter]
		public ScriptBlock OnLoading { get; set; }

		public static RuntimeDefinedParameterDictionary DynamicParameters { get; } = new RuntimeDefinedParameterDictionary();

        public object GetDynamicParameters()
        {
            return DynamicParameters;
        }

        protected override void EndProcessing()
		{
			var page = new Page();
			page.Name = Name;
			page.Url = Url;
			page.Icon = FontAwesomeIconsExtensions.GetIconName(Icon);
			page.Id = Id;
			page.DefaultHomePage = DefaultHomePage;
			page.AutoRefresh = AutoRefresh;
			page.RefreshInterval = RefreshInterval;
			page.Title = Title;
			page.Properties = MyInvocation.BoundParameters;
			page.Blank = Blank;
			page.Loading = OnLoading?.Invoke();

			try
			{
				if (Url != null && !Url.StartsWith("/"))
				{
					Url = "/" + Url;
				}

				if (Url == null && Name != null)
				{
					page.Url = "/" + Name.Replace(' ', '-');
				}

				page.Name = Name;
				page.Callback = Content.GenerateCallback(Id, this, SessionState, ArgumentList);
				page.Dynamic = true;
			}
			catch (Exception ex)
			{
				WriteError(new ErrorRecord(ex, string.Empty, ErrorCategory.SyntaxError, page));

				page.Error = new Error
				{
					Message = ex.Message,
					Location = this.MyInvocation.PositionMessage
				};
			}

			Log.Debug(JsonConvert.SerializeObject(page));

			WriteObject(page);
		}
	}
}
