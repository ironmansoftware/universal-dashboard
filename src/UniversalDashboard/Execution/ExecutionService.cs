using System;
using System.Linq;
using System.Threading.Tasks;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;

namespace UniversalDashboard.Execution
{
    public class ExecutionService : IExecutionService
    {
        private readonly ILanguageExecutionService[] executionServices;

        public ExecutionService(ILanguageExecutionService[] executionServices)
        {
            this.executionServices = executionServices;
        }

        public async Task<object> ExecuteEndpointAsync(ExecutionContext context, AbstractEndpoint endpoint)
        {
            var executionService = this.executionServices.FirstOrDefault(m => m.Language == endpoint.Language);

            if (executionService == null)
            {
                throw new Exception($"Execution service for {endpoint.Language} not defined.");
            }

            return await executionService.ExecuteEndpointAsync(context, endpoint);

        }
    }
}
