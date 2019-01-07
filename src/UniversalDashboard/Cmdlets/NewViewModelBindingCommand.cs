using System.Collections;
using System.Management.Automation;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDViewModelBinding")]
    public class NewViewModelBindingCommand : PSCmdlet
    {
        [Parameter(Mandatory = true, Position = 1)]
        public string ViewModelName { get; set; }

        [Parameter(Mandatory = true, Position = 2)]
        public Hashtable BoundProperties { get; set; }

        protected override void EndProcessing()
        {
            WriteObject(new ViewModelBinding(ViewModelName, BoundProperties));
        }
    }
}
