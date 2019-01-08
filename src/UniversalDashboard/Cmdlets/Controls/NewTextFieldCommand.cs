using System.Management.Automation;
using UniversalDashboard.Models;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Cmdlets.Controls
{
    [Cmdlet(VerbsCommon.New, "UDTextField")]
    public class NewTextFieldCommand : BindableComponentCmdlet
    {
        [Parameter]
        public string Name { get; set; }

        [Parameter]
        public string Placeholder { get; set; }

        [Parameter]
        [Endpoint]
        public object OnBlur { get; set; }

        protected override void EndProcessing()
        {
            var textField = new TextField();
            textField.Name = Name;
            textField.Placeholder = Placeholder;
            textField.ViewModelBinding = GetViewModelBinding();

            WriteObject(textField);
        }
    }
}
