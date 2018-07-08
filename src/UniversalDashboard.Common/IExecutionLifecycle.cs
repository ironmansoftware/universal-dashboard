using UniversalDashboard.Execution;

namespace UniversalDashboard.Interfaces
{
    public interface IExecutionLifecycle
    {
        void BeforeEndpointExecution(ExecutionContext executionContext);
        object AfterEndpointExecution(object result);
    }
}
