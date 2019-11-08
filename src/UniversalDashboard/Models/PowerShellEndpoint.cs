using System.Management.Automation;
using UniversalDashboard.Common.Models;

namespace UniversalDashboard.Models
{
    public class Endpoint : AbstractEndpoint
    {
        public Endpoint()
        {

        }

        public Endpoint(ScriptBlock scriptBlock)
        {
            ScriptBlock = scriptBlock;
        }

        public override Language Language => Language.PowerShell; 

        public ScriptBlock ScriptBlock { get; set; }

        public override bool HasCallback => ScriptBlock != null;
    }
}
