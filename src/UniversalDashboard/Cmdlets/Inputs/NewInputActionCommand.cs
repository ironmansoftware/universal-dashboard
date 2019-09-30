using System.Linq;
using System.Management.Automation;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets.Inputs
{
	[Cmdlet(VerbsCommon.New, "UDInputAction", DefaultParameterSetName = "clear")]
    public class NewInputActionCommand : PSCmdlet
    {
		[Parameter(Mandatory = true, ParameterSetName = "toast")]
		public string Toast { get; set; }

	    [Parameter(ParameterSetName = "toast")]
	    public int Duration { get; set; } = 1000;

	    [Parameter(Mandatory = true, ParameterSetName = "redirect")]
		public string RedirectUrl { get; set; }

		[Parameter(Mandatory = true, ParameterSetName = "content")]
		public object Content { get; set; }

		[Parameter()]
		public SwitchParameter ClearInput { get; set; }

		protected override void EndProcessing()
	    {
			var inputAction = new InputAction();

		    if (ParameterSetName == "toast")
		    {
			    inputAction.Type = InputAction.Toast;
			    inputAction.Text = Toast;
				inputAction.ClearInput = ClearInput;
			    inputAction.Duration = Duration;
		    }

			if (ParameterSetName == "clear")
		    {
				inputAction.Type = InputAction.Clear;
				inputAction.ClearInput = ClearInput;
		    }

		    if (ParameterSetName == "redirect")
		    {
			    inputAction.Type = InputAction.Redirect;
			    inputAction.Route = RedirectUrl;
		    }

			if (ParameterSetName == "content")
			{
				inputAction.Type = InputAction.Content;

				if (Content is ScriptBlock scriptBlock) {
                    inputAction.Components = scriptBlock.Invoke();
				}
                else
                {
                    inputAction.Components = Content;
                }
			}

			WriteObject(inputAction);

	    }
    }
}
