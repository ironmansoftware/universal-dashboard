using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using NLog;

namespace UniversalDashboard.Controllers
{
	public class RedirectController : Controller
	{
		private readonly IHostingEnvironment _hostingEnvironment;
		private readonly Logger Log = LogManager.GetLogger(nameof(RedirectController));

		public RedirectController(IHostingEnvironment env)
		{
			_hostingEnvironment = env;
		}

		[Route("/redirect/{statusCode}")]
		public IActionResult Index(int statusCode)
		{
			var filePath = _hostingEnvironment.ContentRootPath + "/index.html";
			Log.Debug($"Index - statusCode = {statusCode}, filePath = {filePath}");
			if (!System.IO.File.Exists(filePath))
			{
				Log.Warn("Static file does not exist.");

				return StatusCode(statusCode);
			}
			return PhysicalFile(filePath, "text/html");
		}
	}
}
