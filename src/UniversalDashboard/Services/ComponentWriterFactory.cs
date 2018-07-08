using UniversalDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace UniversalDashboard.Services
{
    public class ComponentWriterFactory
    {
		private readonly IEnumerable<ComponentWriter> _writers;

		public ComponentWriterFactory()
		{
			_writers = new List<ComponentWriter>
			{
				new ElementWriter(this),
				new DefaultComponentWriter() // Needs to be last one
			};
		}

		public ComponentWriter GetWriter(Component component)
		{
			var writer = _writers.FirstOrDefault(m => m.CanWrite(component));
			if (writer == null)
			{
				throw new Exception($"No writer for component type '{component.GetType().Name}'. Did you add a writer to ComponentWriterFactory?");
			}

			return writer;
		}
    }
}
