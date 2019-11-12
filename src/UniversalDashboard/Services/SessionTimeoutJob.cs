using System;
using System.Threading.Tasks;
using NLog;
using Quartz;

namespace UniversalDashboard.Services
{
    public class SessionTimeoutJob : IJob
    {
        private readonly Logger logger = LogManager.GetLogger(nameof(SessionTimeoutJob));

        public TimeSpan IdleTimeout { get; set; }
        public async Task Execute(IJobExecutionContext context)
        {
            await Task.CompletedTask;

            logger.Debug($"Clearing out timed out sessions. IdleTimeout is: {IdleTimeout}");

            foreach (var server in Server.Servers)
            {
                server.DashboardService.EndpointService.SessionManager.ClearTimedOutSessions(IdleTimeout);
            }
        }
    }
}