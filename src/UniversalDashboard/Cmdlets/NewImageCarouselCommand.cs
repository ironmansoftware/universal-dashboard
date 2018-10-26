using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Threading.Tasks;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDImageCarousel")]
    public class NewImageCarouselCommand : PSCmdlet
    {
		[Parameter()]
		public ScriptBlock Items { get; set; }
	    [Parameter]
	    public string Id { get; set; } = Guid.NewGuid().ToString();
	    [Parameter]
	    public SwitchParameter ShowIndecators { get; set; } 
	    [Parameter]
	    public SwitchParameter AutoCycle { get; set; } 
	    [Parameter]
	    public int Speed { get; set; } 
	    [Parameter]
	    public string Width { get; set; } 
	    [Parameter]
	    public string Height { get; set; } 
	    [Parameter]
	    public SwitchParameter FullWidth { get; set; } 
	    [Parameter()]
	    public SwitchParameter FixButton { get; set; } 
	    [Parameter()]
	    public string ButtonText { get; set; } 

		protected override void EndProcessing()
	    {
		    var items = Items.Invoke().Select(m => m.BaseObject).OfType<ImageCarouselItem>();

		    WriteObject(new ImageCarousel
		    {
				Id = Id,
                ShowIndecators = ShowIndecators,
				Speed = Speed,
				AutoCycle = AutoCycle,
				Width = Width,
				Height = Height,
				FullWidth = FullWidth,
				FixButton = FixButton,
				ButtonText = ButtonText,
			    Items = items.ToList()
		    });
	    }
    }
}

