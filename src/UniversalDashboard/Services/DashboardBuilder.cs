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

            var parts = new List<ComponentParts>();
            foreach(var page in pages)
            {
                parts.AddRange(page.Components.Select(x => WriteComponent(componentWriterFactory, x, page)).Where(m => m != null));
                parts.Add(WriteComponent(componentWriterFactory, page, page));
            }

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

		public DashboardApp Build(IEnumerable<Component> components, Page page)
		{
			var componentWriterFactory = new ComponentWriterFactory();

			var parts = components.Select(x => WriteComponent(componentWriterFactory, x, page)).Where(m => m != null).ToArray();

			var componentParts = new ComponentParts();

			foreach(var part in parts)
				componentParts.Combine(part);

			

			return new DashboardApp
			{
				Endpoints = componentParts.Endpoints,
				ElementScripts = componentParts.ElementScripts
			};
		}

	    private ComponentParts WriteComponent(ComponentWriterFactory factory, Component component, Page page)
	    {
		    return factory.GetWriter(component).Write(component, page);
	    }
	}

	public class DashboardApp
	{
		public string Client { get; set; }
		public IEnumerable<Endpoint> Endpoints { get; set; }
		public Dictionary<int, string> ElementScripts { get; set; }
	}
}
