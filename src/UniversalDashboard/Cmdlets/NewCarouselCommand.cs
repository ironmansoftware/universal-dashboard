using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Threading.Tasks;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets
{
	//[Cmdlet(VerbsCommon.New, "Carousel")]
    public class NewCarouselCommand : PSCmdlet
    {
		[Parameter()]
		public ScriptBlock Pages { get; set; }
	    [Parameter]
	    public string Id { get; set; } = Guid.NewGuid().ToString();

		protected override void EndProcessing()
	    {
		    var pages = Pages.Invoke().Select(m => m.BaseObject).OfType<CarouselPage>();

		    WriteObject(new Carousel
		    {
				Id = Id,
			    Pages = pages.ToList()
		    });
	    }
    }
}

