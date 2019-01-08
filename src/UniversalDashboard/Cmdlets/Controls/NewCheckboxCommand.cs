using System.Management.Automation;
using UniversalDashboard.Models;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Cmdlets.Controls
{
    [Cmdlet(VerbsCommon.New, "UDCheckbox")]
    public class NewCheckboxCommand : BindableComponentCmdlet
    {
        [Parameter]
        public SwitchParameter Checked { get; set; }

        [Parameter]
        public SwitchParameter Disabled { get; set; }

        [Parameter]
        public SwitchParameter DisableRipple { get; set; }

        [Parameter]
        public SwitchParameter Indeterminate { get; set; }

        [Parameter]
        public string Label { get; set; }

        [Parameter]
        [ValidateSet("primary", "secondary", "default")]
        public string Color { get; set; } = "default";

        [Parameter]
        [Endpoint]
        public object OnChange { get; set; }

        protected override void EndProcessing()
        {
            var checkbox = new Checkbox();

            checkbox.Checked = Checked;
            checkbox.Disabled = Disabled;
            checkbox.DisableRipple = DisableRipple;
            checkbox.Indeterminate = Indeterminate;
            checkbox.Label = Label;
            checkbox.Color = Color;
            checkbox.ViewModelBinding = GetViewModelBinding();

            WriteObject(checkbox);
        }
    }
}
