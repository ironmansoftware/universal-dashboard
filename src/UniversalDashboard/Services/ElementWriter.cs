using System.Collections.Generic;
using System.Linq;
using UniversalDashboard.Models;
using UniversalDashboard.Models.Basics;

namespace UniversalDashboard.Services
{
    public class ElementWriter : ComponentWriter
	{
        private readonly ComponentWriterFactory _factory;

		public ElementWriter(ComponentWriterFactory factory)
		{
			_factory = factory;
		}

		public override bool CanWrite(Component component)
		{
			return component is Element;
		}

		public override ComponentParts Write(Component component, Page page)
		{
            var element = component as Element;
            var parts = new ComponentParts();
            var endpoints = new List<Endpoint>();

            if (element.JavaScriptPath != null) {
                parts.ElementScripts.Add(element.JavaScriptId.Value, element.JavaScriptPath);
            }

            if (element.Events != null) {
                foreach(var eventHandler in element.Events) {
                    var endpoint = eventHandler.Callback;
                    endpoint.Page = page;
                    endpoint.Name = element.Id + eventHandler.Event;
                    endpoints.Add(endpoint);
                }
            }

            if (element.Callback != null) {
                element.Callback.Name = element.Id;
                endpoints.Add(element.Callback);
            }

            parts.Endpoints = endpoints;

            if (element.Content != null) {
                foreach(var child in element.Content.OfType<Component>()) {
                    var writer = _factory.GetWriter(child);
                    if (writer != null) {
                        var moreParts = writer.Write(child, page);
                        parts.Combine(moreParts);
                    }
                }
            }


			return parts;
		}
	}
}
