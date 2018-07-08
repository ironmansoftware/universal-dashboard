using DasMulli.Win32.ServiceUtils;

namespace UniversalDashboard
{
    class UniversalDashboardService : IWin32Service
    {
        public string ServiceName => "Universal Dashboard";
        private DashboardManager _dashboardManager;

        public void Start(string[] startupArguments, ServiceStoppedCallback serviceStoppedCallback)
        {
            _dashboardManager = new DashboardManager();
            _dashboardManager.Start();
        }

        public void Stop()
        {
            _dashboardManager.Stop();
        }
    }
}