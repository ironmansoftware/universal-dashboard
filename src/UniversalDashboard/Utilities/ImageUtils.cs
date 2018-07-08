using System.IO;

namespace UniversalDashboard.Utilities
{
	public class ImageUtils
    {
		public static string GetImageMimeType(string path)
		{
			var fileInfo = new FileInfo(path);
			switch(fileInfo.Extension.ToLower())
			{
				case ".png":
					return "image/png";
				case ".jpg":
					return "image/jpeg";
				case ".jpeg":
					return "image/jpeg";
				case ".gif":
					return "image/gif";
				default:
					return "image/jpeg";
			}
		}
    }
}
