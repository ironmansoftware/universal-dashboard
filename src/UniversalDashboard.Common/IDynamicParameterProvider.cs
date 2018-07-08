using UniversalDashboard.Interfaces.Models;

namespace UniversalDashboard.Interfaces
{
    public interface ICmdletExtender
    {
        IUdDynamicParameters GetDynamicParameters(string commandKey, object commandObject);
        void ValidateParameters(string commandKey, IDynamicModel model, ICmdlet cmdlet);
    }
}
