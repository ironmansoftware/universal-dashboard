using Microsoft.AspNetCore.Mvc;
using NLog;
using System;

namespace UniversalDashboard.Controllers
{
	public class LogController : Controller
    {
		[HttpPost]
		[Route("/log/{component}/{level}")]
		public IActionResult Log(string component, string level, string message)
		{
			var logger = LogManager.GetLogger("Client." + component);

			if (level.Equals("error", StringComparison.InvariantCultureIgnoreCase))
			{
				logger.Error(message);
			}

			if (level.Equals("info", StringComparison.InvariantCultureIgnoreCase))
			{
				logger.Info(message);
			}

			if (level.Equals("debug", StringComparison.InvariantCultureIgnoreCase))
			{
				logger.Debug(message);
			}

			return Ok();
		}
    }
}
