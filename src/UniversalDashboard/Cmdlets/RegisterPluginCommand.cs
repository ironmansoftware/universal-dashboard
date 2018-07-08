using System.Management.Automation;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsLifecycle.Register, "UDPlugin")]
    public class RegisterPluginCommand : PSCmdlet
    {
        [Parameter()]
        public string AssemblyPath { get; set; }

        protected override void EndProcessing()
        {
            PluginRegistry.Instance.RegisterAssembly(AssemblyPath);
        }
    }
}
