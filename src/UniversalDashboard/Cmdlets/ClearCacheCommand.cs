using System.Management.Automation;
using UniversalDashboard.Execution;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Clear, "UDCache")]
    public class ClearCacheCommand : PSCmdlet
    {
        [Parameter(Position = 0)]
        public string Key { get; set; }

        protected override void EndProcessing()
        {
            if (!string.IsNullOrWhiteSpace(Key)) {
                GlobalCachedVariableProvider.Cache.Remove(Key);
            }
            else 
            {
                GlobalCachedVariableProvider.Cache.Clear();
            }
            
        }
    }
}