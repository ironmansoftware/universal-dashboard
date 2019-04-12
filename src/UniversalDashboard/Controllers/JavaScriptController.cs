using Microsoft.AspNetCore.Mvc;
using NLog;
using System;
using UniversalDashboard.Services;

namespace PowerShellProTools.UniversalDashboard.Controllers
{
    [Route("api/internal/javascript")]
    public class JavaScriptController : Controller
    {
        private readonly Logger Log = LogManager.GetLogger(nameof(JavaScriptController));

        [Route("{asset}")]
        public IActionResult Index(string asset)
        {
            var filePath = AssetService.Instance.FindAsset(asset);
            if (filePath == null)
            {
                Log.Warn($"Unknown element script: {asset}");
                return StatusCode(404);
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
