using UniversalDashboard;
using UniversalDashboard.Services;
using System;
using System.IO;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.Reflection;
using System.Linq;
using UniversalDashboard.Models;
using DasMulli.Win32.ServiceUtils;
using System.Diagnostics;
using System.Threading;

namespace UniversalDashboard
{
    class Program
    {
		private const string RunAsServiceFlag = "--run-as-service";
        private const string NoExecutionPolicy = "--dont-set-execution-policy";

        static void Main(string[] args)
        {
            var dontSetExecutionPolicy = args.Contains(NoExecutionPolicy);

            if (args.Contains(RunAsServiceFlag))
			{
				var service = new UniversalDashboardService(dontSetExecutionPolicy);
				var serviceHost = new Win32ServiceHost(service);
				serviceHost.Run();
			}
			else {
				var dashboardManager = new DashboardManager(dontSetExecutionPolicy);
				dashboardManager.Start();
			}
		}
	}
}
