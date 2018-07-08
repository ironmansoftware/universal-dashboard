using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using System.Collections;
using UniversalDashboard.Services;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDTheme")]
    public class NewThemeCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewThemeCommand));

		[Parameter(Mandatory = true, Position = 1)]
		public string Name { get; set; }
        [Parameter(Mandatory = true, Position = 2)]
		public Hashtable Definition { get; set; }

		[Parameter(Position = 3)]
		public string Parent { get; set; }

		protected override void BeginProcessing()
		{
            var theme = new Theme {
                Name = Name,
                Definition = Definition,
				Parent = Parent
            };

			Log.Debug(JsonConvert.SerializeObject(theme));
			WriteObject(theme);
		}
	}
}
