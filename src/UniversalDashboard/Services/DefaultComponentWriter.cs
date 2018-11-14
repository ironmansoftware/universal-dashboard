using System.Collections.Generic;
using UniversalDashboard.Models;

namespace UniversalDashboard.Services
{
    public class DefaultComponentWriter : ComponentWriter
	{
		public override bool CanWrite(Component component)
		{
			return true;
		}

		public override ComponentParts Write(Component component, Page page)
		{
            if (component.Callback == null)
            {
                return new ComponentParts();
            }

            component.Callback.Name = component.Id;
            component.Callback.Page = page;

            var endpoints = new List<Endpoint> { component.Callback };
            if (component.ChildEndpoints != null)
            {
                foreach(var endpoint in component.ChildEndpoints)
                {
                    endpoint.Page = page;
                    endpoints.Add(endpoint);
                }
            }

            return new ComponentParts
			{
				Endpoints = endpoints
            };
		}
	}
}
