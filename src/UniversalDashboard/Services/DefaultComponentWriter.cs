using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UniversalDashboard.Models;

namespace UniversalDashboard.Services
{
	public class DefaultComponentWriter : ComponentWriter
	{
		public override bool CanWrite(Component component)
		{
			return true;
		}

		public override ComponentParts Write(Component component)
		{
            if (component.Callback == null)
            {
                return new ComponentParts();
            }

            component.Callback.Name = component.Id;

			return new ComponentParts
			{
				Endpoints = new List<Endpoint> { component.Callback }
			};
		}
	}
}
