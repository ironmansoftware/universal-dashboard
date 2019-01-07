using System.Collections;
using System.Management.Automation;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDViewModel")]
    public class NewViewModelCommand : PSCmdlet
    {
        [Parameter(Mandatory = true, Position = 1)]
        public string Name { get; set; }

        [Parameter(Mandatory = true, Position = 2)]
        public Hashtable Members { get; set; }

        protected override void EndProcessing()
        {
            WriteObject(new ViewModel(Name, Members));
        }
    }
}
