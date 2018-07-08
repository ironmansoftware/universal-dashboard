using System.Collections.Generic;

namespace UniversalDashboard.Models
{
    public class SessionState
    {
        public SessionState()
        {
            Endpoints = new List<Endpoint>();
            SyncRoot = new object();
        }

        public object SyncRoot { get; set; }

        public List<Endpoint> Endpoints { get; set; }
    }
}
