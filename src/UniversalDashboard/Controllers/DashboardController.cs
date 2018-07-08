using System;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using UniversalDashboard.Models;
using NLog;
using Microsoft.AspNetCore.Authorization;
using System.Management.Automation;
using System.IO;
using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;
using UniversalDashboard.Interfaces;

namespace UniversalDashboard.Controllers
{

	public class DashboardController : Controller
    {
		private readonly Dashboard _dashboard;
		private readonly IDashboardService _dashboardService;
		private readonly IHubContext<DashboardHub> _hub;
		private readonly Logger Log = LogManager.GetLogger(nameof(DashboardController));

		public DashboardController(IDashboardService dashboardService, IHubContext<DashboardHub> hub)
		{
			_dashboard = dashboardService.Dashboard;
			_dashboardService = dashboardService;
			_hub = hub;
		}

		[Authorize]
		[Route("/dashboard")]
        public IActionResult Index()
        {
			Log.Debug("Index");

            Guid sessionId;
            if (HttpContext.Session.TryGetValue("SessionId", out byte[] sessionIdBytes))
            {
                sessionId = new Guid(sessionIdBytes);
            }
            else
            {
                sessionId = Guid.NewGuid();
                HttpContext.Session.Set("SessionId", sessionId.ToByteArray());
            }

			return Json(
				new { dashboard = _dashboard, sessionId = sessionId, authenticated = HttpContext.User.Identity.IsAuthenticated }
			);
        }

		[Authorize]
	    [Route("/dashboard/{page}")]
	    public Page Index(string page)
	    {
			Log.Debug($"Index - Page = {page}");
			return _dashboard.Pages.FirstOrDefault(m => m.Name?.Replace("-", " ").Equals(page?.Replace("-", " "), StringComparison.OrdinalIgnoreCase) == true);
	    }

		[Authorize]
		[Route("/dashboard/theme")]
	    public IActionResult Theme()
	    {
				return new ContentResult()
            {
                Content = _dashboard?.Themes?.FirstOrDefault()?.RenderedContent,
                ContentType = "text/css",
            };
	    }

        //TODO: Move to enterprise

        //[Authorize]
        //[Route("/dashboard/loadingoptions")]
        //public IActionResult LoadingOptions()
        //{
        //    return new JsonResult(new
        //    { _dashboard?.LoadingScreen?.BackgroundColor,
        //      _dashboard?.LoadingScreen?.TextColor,
        //      _dashboard?.LoadingScreen?.ShowSplash,
        //      _dashboard?.LoadingScreen?.Text
        //    });
        //}

        //TODO: Move to enterprise

        [Route("/api/dashboard/reload")]
		public async Task<IActionResult> Reload() {
			if (_dashboardService.ReloadToken == null) {
				return StatusCode(403);
			}

			if (!HttpContext.Request.Headers.ContainsKey("x-ud-reload-token") || HttpContext.Request.Headers["x-ud-reload-token"].FirstOrDefault() != _dashboardService.ReloadToken) {
				return StatusCode(403);
			}

			await _hub.Clients.All.InvokeAsync("reload");

			return Ok();
		}

		[HttpPost]
		[Route("/api/dashboard")]
		public async Task<IActionResult> Post() {
			if (_dashboardService.UpdateToken == null) {
				return StatusCode(403);
			}

			if (!HttpContext.Request.Headers.ContainsKey("x-ud-update-token") || HttpContext.Request.Headers["x-ud-update-token"].FirstOrDefault() != _dashboardService.UpdateToken) {
				return StatusCode(403);
			}

			string dashboardScript;
			using (var streamReader = new StreamReader(Request.Body))
			{
				dashboardScript = streamReader.ReadToEnd();
			}

			if (String.IsNullOrEmpty(dashboardScript)) {
				return StatusCode(400);
			}

			try 
			{
				using(var powershell = PowerShell.Create()) {
					powershell.AddScript(dashboardScript);
					var dashboard = powershell.Invoke().FirstOrDefault()?.BaseObject as Dashboard;

					if (dashboard == null) {
						return StatusCode(400);
					}

					_dashboardService.SetDashboard(dashboard);
					System.IO.File.WriteAllText(Constants.CachedDashboardPath, dashboardScript);
					await _hub.Clients.All.InvokeAsync("reload");
				}
			}
			catch 
			{
				return StatusCode(400);
			}

			return Ok();
		}
	}
}
