using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using System.Collections;
using UniversalDashboard.Services;
using System.IO;
using System.Reflection;
using System.Linq;
using System;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.Get, "UDTheme")]
    public class GetThemeCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(GetThemeCommand));

        [Parameter(Position = 1)]
        public string Name { get; set; }

		protected override void BeginProcessing()
		{
             var themeService = new ThemeService();

             foreach(var theme in themeService.LoadThemes()) {

                if (theme.Name == "Test")
                    continue;

                if (Name != null && !theme.Name.Equals(Name, StringComparison.OrdinalIgnoreCase)) {
                    continue;
                }

                 WriteObject(theme);
             }
		}
	}
}
