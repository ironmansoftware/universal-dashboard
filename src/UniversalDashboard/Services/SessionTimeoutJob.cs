using System;
using System.Threading.Tasks;
using Quartz;
using UniversalDashboard.Execution;

namespace UniversalDashboard.Services
{
    public class SessionTimeoutJob : IJob
    {
        public TimeSpan IdleTimeout { get; set; }
        public async Task Execute(IJobExecutionContext context)
        {
            await Task.CompletedTask;
            EndpointService.Instance.SessionManager.ClearTimedOutSessions(IdleTimeout);
        }
    }
}