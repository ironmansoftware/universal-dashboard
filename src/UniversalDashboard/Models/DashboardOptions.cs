using System;
using System.Collections.Generic;
using UniversalDashboard.Models;
using System.Security.Cryptography.X509Certificates;
using System.Security;
using UniversalDashboard.Interfaces.Models;

namespace UniversalDashboard
{
    public class DashboardOptions : IDynamicModel {
        public Dashboard Dashboard { get; set; }
        public IEnumerable<Endpoint> StaticEndpoints { get; set; } 
        public int Port { get; set; } 
        public bool Wait { get; set; }
        public X509Certificate2 Certificate { get; set; }
        public string CertificateFile { get; set; } 
        public SecureString Password { get; set; }
        public Endpoint EndpointInitializationScript { get; set; }
        public string UpdateToken { get; set; }
        public Dictionary<Guid, string> ElementScripts { get; set; }
        public Dictionary<string, object> Properties { get; set; }
    }
}