using Microsoft.AspNetCore.SignalR;
using System.Linq;
using System.Management.Automation;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.Show, "UDModal")]                    
    public class ShowModalCommand : PSCmdlet
    {
        [Parameter()]
        public SwitchParameter BottomSheet { get; set; }
        [Parameter()]
        public SwitchParameter FixedFooter { get; set; }
        [Parameter()]
        public ScriptBlock Footer { get; set; }
        [Parameter()]
        public ScriptBlock Header { get; set; }
        [Parameter()]
        public ScriptBlock Content { get; set; }
        [Parameter()]
        public DashboardColor BackgroundColor { get; set; }
        [Parameter()]
        public DashboardColor FontColor { get; set; }
        [Parameter()]
        public string Height { get; set; }
        [Parameter()]
        public string Width { get; set; }
        [Parameter()]
        public SwitchParameter Persistent { get; set; }

        protected override void EndProcessing()
        {
            var modal = new Modal
            {
                BottomSheet = BottomSheet,
                FixedFooter = FixedFooter,
                Footer = Footer?.Invoke().Select(m => m.BaseObject).ToArray(),
                Header = Header?.Invoke().Select(m => m.BaseObject).ToArray(),
                Content = Content?.Invoke().Select(m => m.BaseObject).ToArray(),
                BackgroundColor = BackgroundColor?.HtmlColor,
                FontColor = FontColor?.HtmlColor,
                Height = Height,
                Width = Width,
                Dismissible = !Persistent.IsPresent
            };

            var hub = this.GetVariableValue("DashboardHub") as IHubContext<DashboardHub>;
            if (hub != null)
            {
                var connectionId = this.GetVariableValue("ConnectionId") as string;
                hub.ShowModal(connectionId, modal).Wait();
            }
        }
    }
}
