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
    public class NewPageCommand : CallbackCmdlet, IDynamicParameters
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewPageCommand));

		[Parameter(Position = 0, Mandatory = true, ParameterSetName = "name")]
		public string Name { get; set; }
	    [Parameter(Position = 1)]
		public FontAwesomeIcons Icon { get; set; }
	    [Parameter(Position = 2)]
		public ScriptBlock Content { get; set; }
		[Parameter(Position = 0, Mandatory = true, ParameterSetName = "url")]
		public string Url { get; set; }

		[Parameter(Position = 3)]
		public SwitchParameter DefaultHomePage { get; set; }

		[Parameter(Position = 4)]
		public string Title { get; set; }

		[Parameter]
		public SwitchParameter Blank { get; set; }

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

			if (Content != null && Endpoint != null) {
				throw new Exception("Content and Endpoint cannot both be specified.");
			}

			try
			{
				if (Endpoint != null)
				{
                    if (Url != null && !Url.StartsWith("/"))
                    {
                        Url = "/" + Url;
                    }

                    if (Url == null && Name != null)
                    {
                        page.Url = "/" + Name;
                    }

					page.Callback = GenerateCallback(Id);
					page.Dynamic = true;
				}
				else
				{
					var components = Content.Invoke();

					foreach (var component in components)
					{
                        if (component.BaseObject is Component dashboardComponent)
                        {
                            page.Components.Add(dashboardComponent);
                        }

                        if (component.BaseObject is Dictionary<string, object> dictionary)
                        {
                            page.Components.Add(new GenericComponent(dictionary));
                        }

						if (component.BaseObject is Hashtable hashtable)
                        {
                            page.Components.Add(new GenericComponent(hashtable));
                        }
                    }

                    page.Name = page.Name.TrimStart('/');
					page.Dynamic = false;
				}
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
