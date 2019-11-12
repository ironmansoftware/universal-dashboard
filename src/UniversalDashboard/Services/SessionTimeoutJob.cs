using System;
using System.Threading.Tasks;
using Quartz;

namespace UniversalDashboard.Services
{
    public class SessionTimeoutJob : IJob
    {
        public TimeSpan IdleTimeout { get; set; }
        public async Task Execute(IJobExecutionContext context)
        {
            await Task.CompletedTask;

            foreach (var server in Server.Servers)
            {
                server.DashboardService.EndpointService.SessionManager.ClearTimedOutSessions(IdleTimeout);
            }
        }
    }
}