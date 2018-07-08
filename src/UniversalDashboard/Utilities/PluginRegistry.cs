using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UniversalDashboard.Interfaces;

namespace UniversalDashboard.Utilities
{
    public class PluginRegistry
    {
        private readonly List<IPlugin> _plugins;
        private static PluginRegistry _instance;

        private PluginRegistry()
        {
            _plugins = new List<IPlugin>();
        }

        public static PluginRegistry Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new PluginRegistry();
                }
                return _instance;
            }
        }

        public void RegisterAssembly(string path)
        {
            var assembly = Assembly.LoadFrom(path);
            var pluginTypes = assembly.GetTypes().Where(m => m.GetInterfaces().Any(x => x == typeof(IPlugin)));

            foreach(var pluginType in pluginTypes)
            {
                try
                {
                    var plugin = (IPlugin)Activator.CreateInstance(pluginType);
                    _plugins.Add(plugin);
                }
                catch
                {

                }
            }
        }

        public IEnumerable<IPlugin> Plugins => _plugins;
    }
}
