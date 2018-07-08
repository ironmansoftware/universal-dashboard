using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace UniversalDashboard.Models
{
    public class CarouselPage : Component
    {
		public string BackgroundColor { get; set; }
		public string ForegroundColor { get; set; }
		public Component Child { get; set; }
		public override string Type => "carouselPage";
	}
}
