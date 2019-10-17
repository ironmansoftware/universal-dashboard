using System.Collections.Generic;
using System.Management.Automation;
using System.Text.RegularExpressions;

namespace UniversalDashboard.Models
{
    public class Endpoint
    {
        public Endpoint()
        {

        }

        public Endpoint(ScriptBlock scriptBlock)
        {
            ScriptBlock = scriptBlock;
        }

		public ScriptBlock ScriptBlock { get; set; }
		public Dictionary<string, object> Variables { get; set; }
        public object[] ArgumentList { get; set; }
        public string Name { get; set; }
        public string Url { get; set; }
        public string Method { get; set; }
        public Part[] Parts { get; set; }
        public EndpointSchedule Schedule { get; set; }
        public string SessionId { get; set; }
        internal Page Page { get; set; }
        public Regex UrlRegEx { get; set; }
        public bool AcceptFileUpload {get; set;}
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
