using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace UniversalDashboard.Models
{
    public class ImageCarousel : Component
    {
		public List<ImageCarouselItem> Items { get; set; } = new List<ImageCarouselItem>();
		public Boolean ShowIndecators { get; set; }
		public Boolean AutoCycle { get; set; }
		public int Speed { get; set; }
		public string Width { get; set; }
		public string Height { get; set; }
		public Boolean FullWidth { get; set; }
		public Boolean FixButton { get; set; }
		public string ButtonText { get; set; }
		public override string Type => "imageCarousel";
	}
}