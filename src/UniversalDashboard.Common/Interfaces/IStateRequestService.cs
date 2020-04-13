using System.Collections;
using System.Threading;

namespace UniversalDashboard.Interfaces 
{
    public interface IStateRequestService 
    {
        void Set(string requestId, Hashtable state);
        bool TryGet(string requestId, out Hashtable element);
        AutoResetEvent EventAvailable { get; }
    }
}