using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using NLog;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Services;

namespace UniversalDashboard.Controllers
{
	public class PluginController : Controller
	{
		private readonly Logger Log = LogManager.GetLogger(nameof(PluginController));

		[Route("/plugin")]
		public IActionResult Index()
		{
            return Json(Utilities.PluginRegistry.Instance.Plugins);
        }
	}
}
