using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Threading.Tasks;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets
{
	//[Cmdlet(VerbsCommon.New, "CarouselPage")]
    public class NewCarouselPageCommand : PSCmdlet
    {
		[Parameter(Mandatory = true)]
		public ScriptBlock Content { get; set; }

	    [Parameter()]
	    public string BackgroundColor { get; set; } = "#000";

	    [Parameter()]
	    public string ForegroundColor { get; set; } = "#fff";

	    [Parameter]
	    public string Id { get; set; } = Guid.NewGuid().ToString();

		protected override void EndProcessing()
	    {
		    var component = Content.Invoke().First().BaseObject as Component;

		    WriteObject(new CarouselPage
		    {
				Id = Id,
				BackgroundColor = BackgroundColor,
				ForegroundColor = ForegroundColor,
				Child = component
		    });
	    }
    }
}
