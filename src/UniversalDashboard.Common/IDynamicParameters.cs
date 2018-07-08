using System.Collections.Generic;

namespace UniversalDashboard.Interfaces
{
    public interface IUdDynamicParameters
    {
        Dictionary<string, object> AsDictionary();
    }
}
