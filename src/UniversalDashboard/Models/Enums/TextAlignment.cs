using System;

namespace UniversalDashboard.Models.Enums
{
    public enum TextAlignment
	{
        left,
        center,
        right
    }

    public static class TextAlignmentExtensions
	{
		public static string GetName(this TextAlignment icon)
		{
			return Enum.GetName(typeof(TextAlignment), icon).TrimStart('_').Replace("_", "-");
		}
	}
}