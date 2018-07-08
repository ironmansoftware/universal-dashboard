using System;
using System.Collections.Generic;
using System.Linq;
using NLog;
using UniversalDashboard.Models;

namespace UniversalDashboard.Services
{
    public class DashboardBuilder
    {
		private static readonly Logger Log = LogManager.GetLogger(nameof(DashboardBuilder));
		public DashboardApp Build(Dashboard dashboard)
		{
			return Build(dashboard.Pages);
		}

		public DashboardApp Build(IEnumerable<Page> pages)
	    {
			var componentWriterFactory = new ComponentWriterFactory();

			var parts = pages.SelectMany(m => m.Components).Select(x => WriteComponent(componentWriterFactory, x)).Where(m => m != null).ToArray();
			parts = parts.Concat(pages.Select(m => WriteComponent(componentWriterFactory, m)).Where(m => m != null).ToArray()).ToArray();

			var componentParts = new ComponentParts();

			foreach(var part in parts)
				componentParts.Combine(part);

			foreach(var endpoint in componentParts.Endpoints) {
				Log.Debug("Adding endpoint: " + endpoint.Url);
			}

			return new DashboardApp
			{
				Endpoints = componentParts.Endpoints,
				ElementScripts = componentParts.ElementScripts
			};
	    }

		public DashboardApp Build(IEnumerable<Component> components)
		{
			var componentWriterFactory = new ComponentWriterFactory();

			var parts = components.Select(x => WriteComponent(componentWriterFactory, x)).Where(m => m != null).ToArray();

			var componentParts = new ComponentParts();

			foreach(var part in parts)
				componentParts.Combine(part);

			

			return new DashboardApp
			{
				Endpoints = componentParts.Endpoints,
				ElementScripts = componentParts.ElementScripts
			};
		}

	    private ComponentParts WriteComponent(ComponentWriterFactory factory, Component component)
	    {
		    return factory.GetWriter(component).Write(component);
	    }
	}

	public class DashboardApp
	{
		public string Client { get; set; }
		public IEnumerable<Endpoint> Endpoints { get; set; }
		public Dictionary<int, string> ElementScripts { get; set; }
	}
}
