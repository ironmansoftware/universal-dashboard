using System;
using System.IO;
using System.Reflection;

namespace UniversalDashboard {
    public class Constants {
        public static readonly string Edition = "Community";
        public static readonly string AssemblyBasePath = Path.GetDirectoryName(typeof(Constants).GetTypeInfo().Assembly.Location);
        public static readonly string DashboardService = "DashboardService";
        public static readonly string DemoDashboardPath = Path.Combine(AssemblyBasePath, "..", "poshud", "dashboard.ps1");
        public static readonly string CachedDashboardPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), "UniversalDashboard", "dashboard.ps1");
        public static readonly string SessionId = "SessionId";
        public static readonly string SessionState = "SessionState";
        public static readonly string ModuleManifest = "UniversalDashboard.Community.psd1";
        public static readonly string UDPage = "UDPage";
    }
}
