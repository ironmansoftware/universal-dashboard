using System.Collections.Concurrent;
using System.Collections.Generic;
using UniversalDashboard.Models;

namespace UniversalDashboard.Services
{
    public class ConnectionManager
    {
        public ConcurrentDictionary<string, Connection> Connections { get; private set; }
        private static object Sync = new object();

        public ConnectionManager()
        {
            Connections = new ConcurrentDictionary<string, Connection>();
        }

        public void AddConnection(Connection connection)
        {
            if (!Connections.ContainsKey(connection.Id.ToLower()))
            {
                Connections.TryAdd(connection.Id.ToLower(), connection);
            }
        }

        public void RemoveConnection(string id)
        {
            Connections.TryRemove(id.ToLower(), out Connection value);
        }

        public string GetSessionId(string id)
        {
            if (Connections.ContainsKey(id.ToLower()))
            {
                return Connections[id.ToLower()].SessionId;
            }

            return null;
        }
    }
}
