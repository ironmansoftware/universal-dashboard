using Microsoft.AspNetCore.Mvc;
using NLog;
using System;
using UniversalDashboard.Interfaces;

namespace PowerShellProTools.UniversalDashboard.Controllers
{
    public class JavaScriptController : Controller
    {
        private readonly Logger Log = LogManager.GetLogger(nameof(JavaScriptController));

        private readonly IDashboardService _dashboardService;
        public JavaScriptController(IDashboardService dashboardService)
        {
            _dashboardService = dashboardService;
        }

        [Route("/js/{id}")]
        public IActionResult Index(Guid id)
        {
            if (!_dashboardService.ElementScripts.ContainsKey(id))
            {
                Log.Warn($"Unknown element script: {id}");
                return StatusCode(404);
            }

            var filePath = _dashboardService.ElementScripts[id];

            if (!System.IO.File.Exists(filePath))
            {
                Log.Warn($"Static file [{filePath}] does not exist.");

                return StatusCode(404);
            }
            return PhysicalFile(filePath, "text/javascript");
        }
    }
}
