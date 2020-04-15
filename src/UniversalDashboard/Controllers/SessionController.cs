using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using UniversalDashboard.Interfaces;

namespace UniversalDashboard.Controllers
{
    [Route("api/internal/session")]
    public class SessionController : Controller
    {
        private readonly IDashboardService _dashboardService;

        public SessionController(IDashboardService dashboardService) 
        {
            _dashboardService = dashboardService;
        }

        [HttpGet]
        [Route("{sessionId}")]
        public IActionResult Index(string sessionId) 
        {
            if (_dashboardService.EndpointService.SessionManager.SessionExists(sessionId))
            {
                return Ok();
            }
            return NotFound();
        }
    }
}