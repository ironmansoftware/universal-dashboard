using System;
using System.Collections.Generic;
using UniversalDashboard.Models;
using System.Security.Cryptography.X509Certificates;
using System.Security;
using System.Management.Automation.Runspaces;

namespace UniversalDashboard
{
    public class DashboardOptions {
        public Dashboard Dashboard { get; set; }
        public IEnumerable<Endpoint> StaticEndpoints { get; set; } 
        public int Port { get; set; } 
        public bool Wait { get; set; }
        public X509Certificate2 Certificate { get; set; }
        public string CertificateFile { get; set; } 
        public SecureString Password { get; set; }
        public InitialSessionState EndpointInitialSessionState { get; set; }
        public string UpdateToken { get; set; }
        public Dictionary<Guid, string> ElementScripts { get; set; }
        public PublishedFolder[] PublishedFolders { get; set; }
    }
}