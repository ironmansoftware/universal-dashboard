using System.Collections.Generic;
using System.Text.RegularExpressions;
using UniversalDashboard.Common.Models;

namespace UniversalDashboard.Models
{
    public abstract class AbstractEndpoint
    {
        public abstract bool HasCallback { get; }
        public abstract Language Language { get; }
		public Dictionary<string, object> Variables { get; set; }
        public object[] ArgumentList { get; set; }
        public string Name { get; set; }
        public string Url { get; set; }
        public string Method { get; set; }
        public Part[] Parts { get; set; }
        public EndpointSchedule Schedule { get; set; }
        public string SessionId { get; set; }
        public Page Page { get; set; }
        public Regex UrlRegEx { get; set; }
        public bool AcceptFileUpload {get; set;}
        public bool Asynchronous { get; set; }
        public Dictionary<string, object> Properties { get; set; }
        public string ContentType { get; set; } 
        public string Accept { get; set; }
        public bool IsPage { get; set; }
    }

    public class Part
    {
        public Part(string value, bool isVariable)
        {
            Value = value;
            IsVariable = isVariable;

            if (isVariable)
                Value = Value.TrimStart(':');
        }

        public bool IsVariable { get; set; }
        public string Value { get; set; }
    }
}
