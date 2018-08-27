using NLog;
using System;
using System.IO;
using System.Reflection;

namespace UniversalDashboard.Utilities
{
    public class AssemblyResolver
    {
        private static readonly ILogger Logger = LogManager.GetLogger(nameof(AssemblyResolver));
        public static Assembly OnAssemblyResolve(object sender, ResolveEventArgs args)
        {
            string assemblyNameString = args.Name.Split(',')[0];

            try
            {
                if (assemblyNameString.Contains("UniversalDashboard")) return null;

                var assemblyBasePath = Path.GetDirectoryName(typeof(AssemblyResolver).Assembly.Location);

                var assemblyPath = Path.Combine(
                            assemblyBasePath,
                            assemblyNameString + ".dll");

                if (File.Exists(assemblyPath))
                {
                    return Assembly.LoadFrom(assemblyPath);
                }
                else
                {
                    return null;
                }
            }
            catch (Exception e)
            {
                Logger.Warn($"Exception while loading assembly {assemblyNameString}:\n\n{e.ToString()}");
            }

            return null;
        }
    }
}
