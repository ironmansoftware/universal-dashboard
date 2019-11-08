using System.Management.Automation;
using UniversalDashboard.Common.Models;

namespace UniversalDashboard.Models
{
    public class PowerShellEndpoint : Endpoint
    {
        public PowerShellEndpoint()
        {

        }

        public PowerShellEndpoint(ScriptBlock scriptBlock)
        {
            ScriptBlock = scriptBlock;
        }

        public override Language Language => Language.PowerShell; 

        public ScriptBlock ScriptBlock { get; set; }

        public override bool HasCallback => ScriptBlock != null;
    }
}
