using System.Collections.Concurrent;
using System.Collections.Generic;

namespace UniversalDashboard.Models
{
    public class SessionState
    {
        public SessionState(string id)
        {
            Id = id;
            Endpoints = new ConcurrentDictionary<string, Endpoint>();
            SessionVariables = new ConcurrentDictionary<string, object>();
            Connections = 1;
        }

        public string Id { get; set; }
        public int Connections { get; set; }
        public ConcurrentDictionary<string, Endpoint> Endpoints { get; set; }
        public ConcurrentDictionary<string, object> SessionVariables { get; set; }

        public object GetVariableValue(string name)
        {
            name = name.ToLower();
            if (SessionVariables.ContainsKey(name))
            {
                return SessionVariables[name];
            }
            return null;
        }

        public void SetVariable(string name, object value)
        {
            name = name.ToLower();
            if (SessionVariables.ContainsKey(name))
            {
                SessionVariables[name] = value;
            }
            else 
            {
                SessionVariables.TryAdd(name, value);
            }
        }

        public void RemoveVariable(string name)
        {
            name = name.ToLower();
            if (SessionVariables.ContainsKey(name))
            {
                SessionVariables.TryRemove(name, out object value);
            }
        }
    }
}
