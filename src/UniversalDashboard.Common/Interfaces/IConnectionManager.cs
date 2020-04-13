using UniversalDashboard.Models;

namespace UniversalDashboard.Interfaces 
{
    public interface IConnectionManager 
    {
        void AddConnection(Connection connection);
        void RemoveConnection(string id);
        string GetSessionId(string id);
    }
}