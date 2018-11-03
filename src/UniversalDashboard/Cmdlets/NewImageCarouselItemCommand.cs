using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Threading.Tasks;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDImageCarouselItem")]
    public class NewImageCarouselItemCommand : PSCmdlet
    {
		[Parameter()]
		public string Text { get; set; }

	    [Parameter()]
	    public string BackgroundColor { get; set; } = "#000";
	    [Parameter()]
	    public string BackgroundImage { get; set; }

	    [Parameter()]
	    public string FontColor { get; set; } = "#fff";
	    [Parameter()]
	    public string BackgroundRepeat { get; set; }
	    [Parameter()]
	    public string BackgroundSize { get; set; }
	    [Parameter()]
	    public string BackgroundPosition { get; set; }
	    [Parameter()]
	    public string TitlePosition { get; set; }
	    [Parameter()]
	    public string TextPosition { get; set; }

	    [Parameter]
	    public string Id { get; set; } = Guid.NewGuid().ToString();
	    [Parameter]
	    public string Title { get; set; }
	    [Parameter]
	    public string Url { get; set; }

		protected override void EndProcessing()
	    {

            var carouselItem = new ImageCarouselItem();
            
            // carouselItem.Content = Content?.Invoke().Select(m => m.BaseObject).ToArray();
            carouselItem.Text = Text;
            carouselItem.TextPosition = TextPosition;
            carouselItem.Id = Id;
            carouselItem.BackgroundColor = BackgroundColor;
			carouselItem.BackgroundImage = BackgroundImage;
			carouselItem.BackgroundRepeat = BackgroundRepeat;
			carouselItem.BackgroundSize = BackgroundSize;
			carouselItem.BackgroundPosition = BackgroundPosition;
            carouselItem.FontColor = FontColor;
            carouselItem.Title = Title;
            carouselItem.TitlePosition = TitlePosition;
            carouselItem.Url = Url;
		    
            WriteObject(carouselItem);
	    }
    }
}
