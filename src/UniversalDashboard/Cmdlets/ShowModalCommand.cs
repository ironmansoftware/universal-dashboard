using System.Linq;
using System.Management.Automation;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Show, "UDModal")]                    
    public class ShowModalCommand : PSCmdlet
    {
        [Parameter()]
        public SwitchParameter FullScreen { get; set; }
        [Parameter()]
        public ScriptBlock Footer { get; set; }
        [Parameter()]
        public ScriptBlock Header { get; set; }
        [Parameter()]
        public ScriptBlock Content { get; set; }
        [Parameter()]
        public SwitchParameter Persistent { get; set; }
        [Parameter()]
        public SwitchParameter FullWidth { get; set; }

        [Parameter()]
        [ValidateSet("xs", "sm", "md", "lg", "xl")]
        public string MaxWidth { get; set; } 

        protected override void EndProcessing()
        {
            var modal = new Modal
            {
                Footer = Footer?.Invoke().Select(m => m.BaseObject).ToArray(),
                Header = Header?.Invoke().Select(m => m.BaseObject).ToArray(),
                Content = Content?.Invoke().Select(m => m.BaseObject).ToArray(),
                Dismissible = !Persistent.IsPresent,
                MaxWidth = MaxWidth, 
                FullWidth = FullWidth, 
                FullScreen = FullScreen
            };

            var hub = this.GetCallbackService();
            if (hub != null)
            {
                var connectionId = this.GetVariableValue("ConnectionId") as string;
                hub.ShowModal(connectionId, modal).Wait();
            }
        }
    }
}
