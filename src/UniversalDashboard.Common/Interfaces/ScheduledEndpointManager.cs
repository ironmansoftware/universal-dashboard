using System.Threading.Tasks;
using UniversalDashboard.Models;

namespace UniversalDashboard.Interfaces
{
    public interface IScheduledEndpointManager
    {
        Task RemoveSchedule(string id);
        Task SetEndpointSchedule(AbstractEndpoint endpoint);
    }
}
