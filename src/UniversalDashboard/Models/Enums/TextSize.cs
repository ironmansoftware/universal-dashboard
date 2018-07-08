using System;

namespace UniversalDashboard.Models.Enums
{
    public enum TextSize
	{
        Small,
        Medium,
        Large
    }

    public static class TextSizeExtensions
	{
		public static string GetName(this TextSize icon)
		{
			return Enum.GetName(typeof(TextSize), icon).TrimStart('_').Replace("_", "-");
		}
	}
}