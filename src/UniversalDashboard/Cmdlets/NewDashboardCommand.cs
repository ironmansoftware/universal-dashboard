using System.Management.Automation;
using UniversalDashboard.Models;
using Newtonsoft.Json;
using NLog;
using System;
using UniversalDashboard.Services;
using System.Linq;
using UniversalDashboard.Models.Basics;
using System.Management.Automation.Runspaces;
using System.Collections.Generic;
using System.Collections;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDDashboard")]
	public class NewDashboardCommand : PSCmdlet, IDynamicParameters
	{
		private readonly Logger Log = LogManager.GetLogger(nameof(NewDashboardCommand));

		[Parameter]
		public string Title { get; set; } = "PowerShell Universal Dashboard";

		[Parameter(ParameterSetName = "Content", Mandatory = true)]
		public ScriptBlock Content { get; set; }

		[Parameter(ParameterSetName = "Pages", Mandatory = true)]
		public Page[] Pages { get; set; }

        [Parameter]
		public Hashtable[] NavbarLinks { get; set; }

		[Parameter]
		public string[] Scripts { get; set; }

		[Parameter]
		public string[] Stylesheets { get; set; }

		[Parameter]
		public InitialSessionState EndpointInitialization { get; set; }

		[Parameter]
		public Theme Theme { get; set; }

		[Parameter]
		public SwitchParameter GeoLocation { get; set; }

		[Parameter]
		public TimeSpan IdleTimeout { get; set; } = TimeSpan.FromMinutes(25);

		internal string DefaultFramework { get; set; } = "MaterialUI";

		public static RuntimeDefinedParameterDictionary DynamicParameters { get; } = new RuntimeDefinedParameterDictionary();

        public object GetDynamicParameters()
        {
            return DynamicParameters;
        }

        protected override void EndProcessing()
	    {
			if (EndpointInitialization == null)
			{
				EndpointInitialization = UDRunspaceFactory.GenerateInitialSessionState(SessionState);
			}

			var dashboard = new Dashboard();
			dashboard.Title = Title;
			dashboard.Scripts = Scripts;
			dashboard.Stylesheets = Stylesheets;
			dashboard.EndpointInitialSessionState = EndpointInitialization;
			dashboard.GeoLocation = GeoLocation;
			dashboard.IdleTimeout = IdleTimeout;
			dashboard.Properties = MyInvocation.BoundParameters;

			if (!AssetService.Instance.Frameworks.ContainsKey(DefaultFramework)) {
				throw new Exception($"Invalid DefaultFramework specified. Valid frameworks are {AssetService.Instance.Frameworks.Keys.Aggregate((x,y) => x + ", " + y )}");
			}

			dashboard.FrameworkAssetId = AssetService.Instance.Frameworks[DefaultFramework];

            if (Theme != null) {
				var themeService = new ThemeService();
				Theme.RenderedContent = themeService.Create(Theme);
				dashboard.Themes = new [] {Theme};
			} else {
				var themeService = new ThemeService();
				var defaultTheme = themeService.LoadThemes().First(m => m.Name.Equals("Default"));
				defaultTheme.RenderedContent = themeService.Create(defaultTheme);
				dashboard.Themes = new [] {defaultTheme};
			}

		    if (ParameterSetName == "Content")
		    {
				var page = new Page();
				page.Name = "home";
				dashboard.Pages.Add(page);

				try
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
				}
				catch (Exception ex)
				{
					WriteError(new ErrorRecord(ex, string.Empty, ErrorCategory.SyntaxError, dashboard));

					dashboard.Error = ex.Message;
				}
			}

		    if (ParameterSetName == "Pages")
		    {
			    dashboard.Pages.AddRange(Pages);
		    }

			Log.Debug(JsonConvert.SerializeObject(dashboard));

		    WriteObject(dashboard);
	    }
    }
}
