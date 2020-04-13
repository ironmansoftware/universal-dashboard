using System.Collections.Concurrent;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;

namespace UniversalDashboard.Services
{
    public class ConnectionManager : IConnectionManager
    {
        private ConcurrentDictionary<string, Connection> Connections { get; set; }

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
