
using System.Collections.Generic;

namespace UniversalDashboard.Services
{
    public class Debugger 
    {
        internal List<string> BreakOnEndpoints { get; private set; } = new List<string>();

        public void BreakOnEndpoint(string id)
        {
            BreakOnEndpoints.Add(id.ToLower());
        }

        public void ClearEndpoint(string id)
        {
            BreakOnEndpoints.Remove(id.ToLower());
        }

        public bool ShouldBreak(string id)
        {
            return BreakOnEndpoints.Contains(id.ToLower());
        }
    }
}