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
        public SwitchParameter AutoFocus { get; set; }

        [Parameter]
        public SwitchParameter Disabled { get; set; }

        [Parameter]
        public SwitchParameter Error { get; set; }

        [Parameter]
        public SwitchParameter FullWidth { get; set; }

        [Parameter]
        public string DefaultValue { get; set; }

        [Parameter]
        public string HelperText { get; set; }

        [Parameter]
        [Endpoint]
        public object OnBlur { get; set; }

        [Parameter]
        public SwitchParameter MultiLine { get; set; }

        [Parameter]
        public SwitchParameter Required { get; set; }

        [Parameter]
        public int Rows { get; set; }

        [Parameter]
        public int RowsMax { get; set; }

        [Parameter]
        public string Value { get; set; }

        [Parameter]
        [ValidateSet("standard", "outlined", "filled")]
        public string Variant { get;  set; }

        protected override void EndProcessing()
        {
            var textField = new TextField();
            textField.Name = Name;
            textField.Placeholder = Placeholder;
            textField.AutoFocus = AutoFocus;
            textField.DefaultValue = DefaultValue;
            textField.Disabled = Disabled;
            textField.FullWidth = FullWidth;
            textField.Error = Error;
            textField.HelperText = HelperText;
            textField.Required = Required;
            textField.Rows = Rows;
            textField.RowsMax = RowsMax;
            textField.ViewModelBinding = GetViewModelBinding();

            WriteObject(textField);
        }
    }
}
