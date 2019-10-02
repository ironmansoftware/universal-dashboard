using System.Collections.Generic;

namespace UniversalDashboard.Models
{
    public class SessionState
    {
        public SessionState(string id)
        {
            Id = id;
            Endpoints = new Dictionary<string, Endpoint>();
            SessionVariables = new Dictionary<string, object>();
            ConnectionIds = new List<string>();
            SyncRoot = new object();
        }

        public object SyncRoot { get; set; }
        public string Id { get; set; }
        public List<string> ConnectionIds { get; set; }
        public Dictionary<string, Endpoint> Endpoints { get; set; }
        public Dictionary<string, object> SessionVariables { get; set; }

        public object GetVariableValue(string name)
        {
            name = name.ToLower();
            lock(SyncRoot)
            {
                if (SessionVariables.ContainsKey(name))
                {
                    return SessionVariables[name];
                }
                return null;
            }
        }

        public void SetVariable(string name, object value)
        {
            name = name.ToLower();
            lock(SyncRoot)
            {
                if (SessionVariables.ContainsKey(name))
                {
                    SessionVariables[name] = value;
                }
                else 
                {
                    SessionVariables.Add(name, value);
                }
            }
        }

        public void RemoveVariable(string name)
        {
            name = name.ToLower();
            lock(SyncRoot)
            {
                if (SessionVariables.ContainsKey(name))
                {
                    SessionVariables.Remove(name);
                }
            }
        }
    }
}
