using System;
using System.Linq;
using DasMulli.Win32.ServiceUtils;

namespace UniversalDashboard
{
    class Program
    {
		private const string RunAsServiceFlag = "--run-as-service";

        static void Main(string[] args)
        {
            Server.LoadPlatformSpecificDependencies();

            if (args.Contains(RunAsServiceFlag))
			{
				var service = new UniversalDashboardService();
				var serviceHost = new Win32ServiceHost(service);
				serviceHost.Run();
			}
			else {
				var dashboardManager = new DashboardManager();
				dashboardManager.Start();
			}
		}
	}
}
