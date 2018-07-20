using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using System.Collections;
using UniversalDashboard.Services;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsData.Publish, "UDFolder")]
    public class PublishFolderCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(PublishFolderCommand));

		[Parameter(Mandatory = true, Position = 1)]
		public string Path { get; set; }
        [Parameter(Mandatory = true, Position = 2)]
		public string RequestPath  { get; set; }

		protected override void BeginProcessing()
		{
			var resolvedPath = GetUnresolvedProviderPathFromPSPath(Path);

            var publishedFolder = new PublishedFolder {
                Path = resolvedPath,
                RequestPath = RequestPath
            };

			Log.Debug(JsonConvert.SerializeObject(publishedFolder));
			WriteObject(publishedFolder);
		}
	}
}
