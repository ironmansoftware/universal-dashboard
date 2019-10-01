using System.Collections.Generic;
using UniversalDashboard.Models;

namespace UniversalDashboard.Services
{
    public class ConnectionManager
    {
        public Dictionary<string, Connection> Connections { get; private set; }
        private static object Sync = new object();

        public ConnectionManager()
        {
            Connections = new Dictionary<string, Connection>();
        }

        public void AddConnection(Connection connection)
        {
            lock(Sync)
            {
                Connections.Add(connection.Id.ToLower(), connection);
            }
        }

        public void RemoveConnection(string id)
        {
            lock(Sync)
            {
                Connections.Remove(id.ToLower());
            }
        }

        public string GetSessionId(string id)
        {
            lock(Sync)
            {
                if (Connections.ContainsKey(id.ToLower()))
                {
                    return Connections[id.ToLower()].SessionId;
                }
            }

            return null;
        }
    }
}
