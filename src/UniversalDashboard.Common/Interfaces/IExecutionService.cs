using System.Threading.Tasks;
using UniversalDashboard.Common.Models;
using UniversalDashboard.Execution;
using UniversalDashboard.Models;

namespace UniversalDashboard.Interfaces 
{
    public interface IExecutionService
    {
        Task<object> ExecuteEndpointAsync(ExecutionContext context, AbstractEndpoint endpoint);
        object ExecuteEndpoint(ExecutionContext context, AbstractEndpoint endpoint);
    }

    public interface ILanguageExecutionService {
        Language Language { get; }
		Task<object> ExecuteEndpointAsync(ExecutionContext context, AbstractEndpoint endpoint);
        object ExecuteEndpoint(ExecutionContext context, AbstractEndpoint endpoint);
    }
}
