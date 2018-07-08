using System.Management.Automation;

namespace UniversalDashboard.Models
{
    public class SharedData
    {
        public string Id { get; set; }
        public bool CacheEnabled { get; set; }
        public int? CacheSeconds { get; set; }
        public ScriptBlock Endpoint { get; set; }
    }
}
