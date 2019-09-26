using System;
using System.Drawing;
using NLog;

namespace UniversalDashboard.Models
{
	public class DashboardColor
    {
		private Color _color;
		private readonly Logger Log = LogManager.GetLogger(nameof(DashboardColor));

		public DashboardColor(int argb)
		{
			Log.Debug($"DashboardColor - argb = {argb}");

			_color = Color.FromArgb(argb);
		}

		public DashboardColor(Color color)
		{
			Log.Debug($"DashboardColor - color = {color}");

			_color = color;
		}


		public static DashboardColor Parse(string hexOrName)
		{
			var log = LogManager.GetLogger(nameof(DashboardColor));

			log.Debug($"Parse - hexOrName = {hexOrName}");

			if (hexOrName.StartsWith("#"))
			{
				hexOrName = hexOrName.TrimStart('#');

				if (hexOrName.Length == 3)
				{
					hexOrName += hexOrName;
				}

				if (hexOrName.Length != 3 && hexOrName.Length < 6)
				{
					while(hexOrName.Length < 6)
					{
						hexOrName = "0" + hexOrName;
					}
				}

				if (hexOrName.Length == 6)
				{
					hexOrName = "FF" + hexOrName;
				}

				Int32 iColorInt = Convert.ToInt32(hexOrName.Substring(0), 16);

				log.Debug($"Parse - iColorInt = {iColorInt}");

				return new DashboardColor(iColorInt);
			}
			else if ((hexOrName.ToLower()).Equals("transparent"))
			{
				var color = Color.FromArgb(0, 0, 0, 0);

				log.Debug($"Parse - color = {color}");

				return new DashboardColor(color);
			}
			else
			{
				var color = Color.FromName(hexOrName);

				log.Debug($"Parse - color = {color}");

				return new DashboardColor(color);
			}
			
		}

		public string HtmlColor
		{
			get
			{
				return _color.ToHtmlRgbaColor();
			}
		}

		public override string ToString()
		{
			return HtmlColor;
		}

	}


    internal static class ColorExtensions
    {
        public static string ToHtmlRgbaColor(this Color color)
        {
            var Log = LogManager.GetLogger(nameof(ColorExtensions));

            var htmlAlph = (float)color.A / 255;

            var rgbaColor = $"rgba({color.R}, {color.G}, {color.B}, {htmlAlph.ToString("G", System.Globalization.CultureInfo.InvariantCulture)})";

            Log.Debug(rgbaColor);

            return rgbaColor;
        }
    }
}
