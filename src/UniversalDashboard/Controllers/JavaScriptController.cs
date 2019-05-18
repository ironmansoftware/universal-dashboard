using Microsoft.AspNetCore.Mvc;
using NLog;
using System;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Services;

namespace PowerShellProTools.UniversalDashboard.Controllers
{
    [Route("api/internal/javascript")]
    public class JavaScriptController : Controller
    {
        private readonly Logger Log = LogManager.GetLogger(nameof(JavaScriptController));
        private readonly IDashboardService _dashboardService;
        public JavaScriptController(IDashboardService dashboardService) {
            _dashboardService = dashboardService;
        }

        [Route("framework")]
        public IActionResult Framework() {
            return Index(_dashboardService.Dashboard.FrameworkAssetId);
        }

        [Route("{asset}")]
        public IActionResult Index(string asset)
        {
            var filePath = AssetService.Instance.FindAsset(asset);
            if (filePath == null)
            {
                Log.Warn($"Unknown element script: {asset}");
                return StatusCode(404);
            }

            if (filePath.StartsWith("http")) {
                return Redirect(filePath);
            }

            if (!System.IO.File.Exists(filePath))
            {
                Log.Warn($"Static file [{filePath}] does not exist.");

                return StatusCode(404);
            }
            return PhysicalFile(filePath, "text/javascript");
        }
    }
}
