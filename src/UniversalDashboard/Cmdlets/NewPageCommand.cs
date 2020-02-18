using UniversalDashboard.Models;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDPage")]
    public class NewPageCommand : CallbackCmdlet
    {
		[Parameter(Position = 0, Mandatory = true)]
		public string Url { get; set; }

		protected override void EndProcessing()
		{
			var page = new Page();
			page.Url = Url;
			page.Id = Id;
			page.Callback = GenerateCallback(Id);

			WriteObject(page);
		}
	}
}
