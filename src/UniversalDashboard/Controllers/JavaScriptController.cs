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

        [Route("{id}")]
        public IActionResult Index(Guid id)
        {
            var filePath = AssetService.Instance.GetScript(id);
            if (filePath == null)
            {
                Log.Warn($"Unknown element script: {id}");
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
