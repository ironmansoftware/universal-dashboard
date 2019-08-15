using Microsoft.Extensions.Caching.Memory;
using UniversalDashboard.Models;
using Quartz;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace UniversalDashboard.Execution
{
    public class ScheduledEndpointJob : IJob
    {
        public Endpoint Endpoint { get; set; }
        public IExecutionService ExecutionService { get; set; }
        public IMemoryCache MemoryCache { get; set; }

        public async Task Execute(IJobExecutionContext context)
        {
            await Task.FromResult(0);

            var variables = new Dictionary<string, object> {
                    {"MemoryCache", MemoryCache}
                };

            ExecutionContext executionContext = new ExecutionContext(Endpoint, variables, new Dictionary<string, object>(), null);
            ExecutionService.ExecuteEndpoint(executionContext, Endpoint);
        }
    }
    [DisallowConcurrentExecution]
    public class ScheduledEndpointJobConsecutive : IJob
    {
        public Endpoint Endpoint { get; set; }
        public IExecutionService ExecutionService { get; set; }
        public IMemoryCache MemoryCache { get; set; }

        public async Task Execute(IJobExecutionContext context)
        {
            await Task.FromResult(0);

            var variables = new Dictionary<string, object> {
                    {"MemoryCache", MemoryCache}
                };

            ExecutionContext executionContext = new ExecutionContext(Endpoint, variables, new Dictionary<string, object>(), null);
            ExecutionService.ExecuteEndpoint(executionContext, Endpoint);
        }
    }
}
