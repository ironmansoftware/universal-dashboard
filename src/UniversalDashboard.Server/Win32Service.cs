using DasMulli.Win32.ServiceUtils;

namespace UniversalDashboard
{
    class UniversalDashboardService : IWin32Service
    {
        public string ServiceName => "Universal Dashboard";
        private DashboardManager _dashboardManager;

        private readonly bool _dontSetExecutionPolicy;

        public UniversalDashboardService(bool dontSetExecutionPolicy)
        {
            _dontSetExecutionPolicy = dontSetExecutionPolicy;
        }

        public void Start(string[] startupArguments, ServiceStoppedCallback serviceStoppedCallback)
        {
            _dashboardManager = new DashboardManager(_dontSetExecutionPolicy);
            _dashboardManager.Start();
        }

        public void Stop()
        {
            _dashboardManager.Stop();
        }
    }
}