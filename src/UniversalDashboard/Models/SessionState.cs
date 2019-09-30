using System.Collections.Generic;

namespace UniversalDashboard.Models
{
    public class SessionState
    {
        public SessionState()
        {
            Endpoints = new Dictionary<string, Endpoint>();
            ConnectionIds = new List<string>();
            SyncRoot = new object();
        }

        public object SyncRoot { get; set; }
        public List<string> ConnectionIds { get; set; }
        public Dictionary<string, Endpoint> Endpoints { get; set; }
    }
}
