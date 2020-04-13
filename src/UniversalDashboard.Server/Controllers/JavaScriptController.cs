using Microsoft.AspNetCore.Mvc;
using System;
using System.Text;
using UniversalDashboard.Interfaces;
using System.IO;
using Microsoft.Extensions.Logging;
using UniversalDashboard.Models;

namespace PowerShellProTools.UniversalDashboard.Controllers
{
    [Route("api/internal/javascript")]
    public class JavaScriptController : Controller
    {
        private readonly ILogger _logger;
        private readonly Dashboard _dashboard; 
        private readonly IAssetService _assetService;
        public JavaScriptController(Dashboard dashboard, IAssetService assetService, ILogger<JavaScriptController> logger) {
            _assetService = assetService;
            _dashboard = dashboard;
            _logger = logger;
        }

        [Route("framework")]
        public IActionResult Framework() {
            if (_dashboard.FrameworkAssetId.StartsWith("http")) {
                return Redirect(_dashboard.FrameworkAssetId);
            }

            if (Path.IsPathRooted(_dashboard.FrameworkAssetId))
            {
                return PhysicalFile(_dashboard.FrameworkAssetId, "text/javascript");
            }

            return Index(_dashboard.FrameworkAssetId);
        }

        [Route("plugin")]
        public IActionResult Plugin() {
            var stringBuilder = new StringBuilder();
            foreach(var plugin in _assetService.Plugins) {

                if (plugin.StartsWith("http")) {
                    return Redirect(plugin);
                }

                var pluginContent = System.IO.File.ReadAllText(plugin);
                stringBuilder.AppendLine(pluginContent);
            }

            return Content(stringBuilder.ToString(), "text/javascript");
        }

        [Route("{asset}")]
        public IActionResult Index(string asset)
        {
            var filePath = _assetService.FindAsset(asset);
            if (filePath == null)
            {
                _logger.LogWarning($"Unknown element script: {asset}");
                return StatusCode(404);
            }

            if (filePath.StartsWith("http")) {
                return Redirect(filePath);
            }

            if (!System.IO.File.Exists(filePath))
            {
                _logger.LogWarning($"Static file [{filePath}] does not exist.");

                return StatusCode(404);
            }
            return PhysicalFile(filePath, "text/javascript");
        }
    }
}
