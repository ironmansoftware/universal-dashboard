using System.Management.Automation;
using UniversalDashboard.Execution;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Clear, "UDCache")]
    public class ClearCacheCommand : PSCmdlet
    {
        protected override void EndProcessing()
        {
            GlobalCachedVariableProvider.Cache.Clear();
        }
    }
}