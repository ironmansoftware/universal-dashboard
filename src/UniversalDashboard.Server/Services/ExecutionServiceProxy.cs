using System.Threading.Tasks;
using UniversalDashboard.Execution;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;

namespace UniversalDashboard.Server.Services
{
    public class ExecutionServiceProxy : IExecutionService
    {
        public object ExecuteEndpoint(ExecutionContext context, AbstractEndpoint endpoint)
        {
            throw new System.NotImplementedException();
        }

        public Task<object> ExecuteEndpointAsync(ExecutionContext context, AbstractEndpoint endpoint)
        {
            throw new System.NotImplementedException();
        }
    }
}