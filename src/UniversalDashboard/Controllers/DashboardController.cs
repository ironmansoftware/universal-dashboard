﻿using System;
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
using System.Reflection;
using Microsoft.AspNetCore.Routing;

namespace UniversalDashboard.Controllers
{
	[Route("api/internal/dashboard")]

	public class DashboardController : Controller
    {
		protected readonly Dashboard _dashboard;
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
		[HttpGet]
        [ResponseCache(NoStore = true, Location = ResponseCacheLocation.None)]
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
        [Route("page/{*pageName}")]
        [ResponseCache(NoStore = true, Location = ResponseCacheLocation.None)]
        public Page Page()
        {
            var page = HttpContext.GetRouteValue("pageName") as string;

            Log.Debug($"Index - Page = {page}");
            return _dashboard.Pages.FirstOrDefault(m => m.Name?.Replace("-", " ").Equals(page?.Replace("-", " "), StringComparison.OrdinalIgnoreCase) == true);
        }

		[Route("theme")]
        [ResponseCache(NoStore = true, Location = ResponseCacheLocation.None)]
        public IActionResult Theme()
	    {
            var materializeCss = Path.Combine(Path.GetDirectoryName(GetType().Assembly.Location), "styles", "materialize.min.css");
            var siteCss = Path.Combine(Path.GetDirectoryName(GetType().Assembly.Location), "styles", "site.css");

            var css = System.IO.File.ReadAllText(materializeCss);
            css += System.IO.File.ReadAllText(siteCss);
            css += _dashboard?.Themes?.FirstOrDefault()?.RenderedContent;

            if (_dashboard?.Navigation != null)
            {
                css += Environment.NewLine;
                css += $@"side-nav {{
                            width: {_dashboard.Navigation.Width}px;
                        }}";
            }

            if (_dashboard?.Navigation?.Fixed == true)
            {
                css += Environment.NewLine;
                css += $@"
                        header, main, footer {{
                          padding-left: {_dashboard.Navigation.Width}px;
                        }}

                        @media only screen and (max-width : 992px) {{
                          header, main, footer {{
                            padding-left: 0;
                          }}
                        }}";
            }

			return new ContentResult()
            {
                Content = css,
                ContentType = "text/css",
            };
	    }

        [Route("reload")]
		public async Task<IActionResult> Reload() {
			if (_dashboardService.ReloadToken == null) {
				return StatusCode(403);
			}

			if (!HttpContext.Request.Headers.ContainsKey("x-ud-reload-token") || HttpContext.Request.Headers["x-ud-reload-token"].FirstOrDefault() != _dashboardService.ReloadToken) {
				return StatusCode(403);
			}

			await _hub.Clients.All.SendAsync("reload");

			return Ok();
		}

		[HttpPost]
		public async Task<IActionResult> Post() {
			if (_dashboardService.UpdateToken == null) {
                Log.Warn("No update token specified. Dashboard will not accept Update-UDDashboard.");

				return StatusCode(403);
			}

			if (!HttpContext.Request.Headers.ContainsKey("x-ud-update-token") || HttpContext.Request.Headers["x-ud-update-token"].FirstOrDefault() != _dashboardService.UpdateToken) {
                Log.Warn("Invalid update token specified while attempting to update dashboard.");

                return StatusCode(403);
			}

			string dashboardScript;
			using (var streamReader = new StreamReader(Request.Body))
			{
				dashboardScript = streamReader.ReadToEnd();
			}

			if (String.IsNullOrEmpty(dashboardScript)) {
                Log.Warn("Failed to update dashboard. Dashboard script was null.");

                return StatusCode(400);
			}

			try 
			{
                using(var runspaceRef = _dashboardService.RunspaceFactory.GetRunspace())
                {
                    using (var powershell = PowerShell.Create())
                    {
                        powershell.Runspace = runspaceRef.Runspace;
                        powershell.AddScript(dashboardScript);
                        var dashboard = powershell.Invoke().FirstOrDefault()?.BaseObject as Dashboard;

                        if (powershell.HadErrors)
                        {
                            foreach (var error in powershell.Streams.Error)
                            {
                                Log.Warn("Failed to update dashboard. " + error.ToString());
                            }
                        }

                        if (dashboard == null)
                        {
                            return StatusCode(400);
                        }

                        _dashboardService.SetDashboard(dashboard);

                        try 
                        {
                            System.IO.File.WriteAllText(Constants.CachedDashboardPath, dashboardScript);
                        }
                        catch (Exception ex)
                        {
                            Log.Warn(ex, "Failed to cache dashboard.");
                        }

                        await _hub.Clients.All.SendAsync("reload");

                        Log.Debug("Successfully updated dashboard.");
                    }
                }
			}
			catch (Exception ex) 
			{
                Log.Warn(ex, "Failed to update dashboard.");

				return StatusCode(400);
			}

			return Ok();
		}
	}
}
