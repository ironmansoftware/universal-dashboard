using Microsoft.AspNetCore.Mvc;
using NLog;
using System;
using System.Text;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Services;
using System.IO;

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
            if (_dashboardService.Dashboard.FrameworkAssetId.StartsWith("http")) {
                return Redirect(_dashboardService.Dashboard.FrameworkAssetId);
            }

            if (Path.IsPathRooted(_dashboardService.Dashboard.FrameworkAssetId))
            {
                return PhysicalFile(_dashboardService.Dashboard.FrameworkAssetId, "text/javascript");
            }

            return Index(_dashboardService.Dashboard.FrameworkAssetId);
        }

        [Route("plugin")]
        public IActionResult Plugin() {
            var stringBuilder = new StringBuilder();
            foreach(var plugin in AssetService.Instance.Plugins) {
                var pluginContent = System.IO.File.ReadAllText(plugin);
                stringBuilder.AppendLine(pluginContent);
            }

            return Content(stringBuilder.ToString(), "text/javascript");
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
