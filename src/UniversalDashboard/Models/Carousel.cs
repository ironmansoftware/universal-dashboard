using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace UniversalDashboard.Models
{
    public class Carousel : Component
    {
		public List<CarouselPage> Pages { get; set; } = new List<CarouselPage>();
		public override string Type => "carousel";
	}
}
