using System.Collections.Generic;

namespace UniversalDashboard.Interfaces.Models
{
    public interface IDynamicModel
    {
        Dictionary<string, object> Properties { get; }
    }
}
