using Microsoft.Extensions.Caching.Memory;
using UniversalDashboard.Models;
using Quartz;
using System.Collections.Generic;
using System.Threading.Tasks;
using UniversalDashboard.Interfaces;

namespace UniversalDashboard.Execution
{
    public class ScheduledEndpointJob : IJob
    {
        public Endpoint Endpoint { get; set; }
        public IExecutionService ExecutionService { get; set; }
        public IMemoryCache MemoryCache { get; set; }

        public async Task Execute(IJobExecutionContext context)
        {
            var variables = new Dictionary<string, object> {
                    {"MemoryCache", MemoryCache}
                };

            ExecutionContext executionContext = new ExecutionContext(Endpoint, variables, new Dictionary<string, object>(), null);
            await ExecutionService.ExecuteEndpointAsync(executionContext, Endpoint);
        }
    }

    [DisallowConcurrentExecution]
    public class ScheduledEndpointJobConsecutive : ScheduledEndpointJob
    {
    }
}
