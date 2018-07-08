namespace UniversalDashboard.Interfaces
{
    public interface IPlugin
    {
        IWebServerConfiguration WebServerConfiguration { get; }
        IExecutionLifecycle ExecutionLifecycle { get; }
        ICmdletExtender CmdletExtender { get; }
    }
}
