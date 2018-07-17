
using System.Collections.Generic;
using System.Security.Claims;
using UniversalDashboard.Models;

namespace UniversalDashboard.Execution {
    public class ExecutionContext {
        public ExecutionContext(Endpoint endpoint, Dictionary<string,object> variables, Dictionary<string,object> parameters, ClaimsPrincipal user) {
            Endpoint = endpoint;
            Variables = variables;
            Parameters = parameters;
            User = user;

			if (Variables == null)
				Variables = new Dictionary<string, object>();

			if (Parameters == null)
				Parameters = new Dictionary<string, object>();
        }

        public bool NoSerialization { get; set; }
        public Dictionary<string, object> Variables {get;set;}
        public Dictionary<string, object> Parameters {get;set;}
        public Endpoint Endpoint {get;set;}
        public ClaimsPrincipal User { get; set; }
        public string ConnectionId { get; set; }
        public string SessionId { get; set; }
    }
}