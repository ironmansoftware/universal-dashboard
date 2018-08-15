using System;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using NLog.Fluent;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;

namespace UniversalDashboard.Controllers
{
    public class DynamicControllerBase : Controller
    {
        protected readonly Dashboard _dashboard;
        public DynamicControllerBase(IDashboardService dashboardService)
		{
			_dashboard = dashboardService.Dashboard;
		}

        public Page GetPage(string page)
	    {
			Log.Debug($"Index - Page = {page}");
			return _dashboard.Pages.FirstOrDefault(m => m.Name?.Replace("-", " ").Equals(page?.Replace("-", " "), StringComparison.OrdinalIgnoreCase) == true);
	    }
    }
}