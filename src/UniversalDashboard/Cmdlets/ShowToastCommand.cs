using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using UniversalDashboard.Models.Enums;
using UniversalDashboard.Models.Basics;
using System.Collections;
using System.Linq;
using System.Collections.Generic;
using Microsoft.AspNetCore.SignalR;
using System.Security.Claims;
using System;
using Microsoft.Extensions.Caching.Memory;
using System.Drawing;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.Show, "UDToast")]
    public class ShowToastCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(ShowToastCommand));

        [Parameter(Mandatory = true, Position = 0)]
		public string Message { get; set; }
        [Parameter]
        public DashboardColor MessageColor { get; set; }
        [Parameter]
        public string MessageSize { get; set; }
        [Parameter]
        public int Duration { get; set; } = 1000;
        [Parameter]
        public string Title { get; set; } = string.Empty;
        [Parameter]
        public DashboardColor TitleColor { get; set; }
        [Parameter]
        public string TitleSize { get; set; }
        [Parameter]
        public string Id { get; set; } = Guid.NewGuid().ToString();
        [Parameter]
        public DashboardColor BackgroundColor { get; set; }
        [Parameter]
        [ValidateSet("light", "dark")]
        public string Theme { get; set; }
        [Parameter]
        public FontAwesomeIcons Icon { get; set; }
        [Parameter]
        public DashboardColor IconColor { get; set; }
        [Parameter()]
        [ValidateSet("bottomRight", "bottomLeft", "topRight", "topLeft", "topCenter", "bottomCenter", "center")]
        public string Position { get; set; } = "topRight";
        [Parameter]
        public SwitchParameter HideCloseButton { get; set; }
        [Parameter]
        public SwitchParameter CloseOnClick { get; set; }
        [Parameter]
        public SwitchParameter CloseOnEscape { get; set; }
        [Parameter]
        public SwitchParameter ReplaceToast { get; set; }
        [Parameter]
        public SwitchParameter RightToLeft { get; set; }
        [Parameter]
        public SwitchParameter Balloon { get; set; }
        [Parameter]
        public SwitchParameter Overlay { get; set; }
        [Parameter]
        public SwitchParameter OverlayClose { get; set; }
        [Parameter]
        public DashboardColor OverlayColor { get; set; } = new DashboardColor(Color.FromArgb(153, 0, 0, 0));
        [Parameter]
        [ValidateSet("bounceInLeft", "bounceInRight", "bounceInUp", "bounceInDown", "fadeIn", "fadeInDown", "fadeInUp", "fadeInLeft", "fadeInRight", "flipInX")]
        public string TransitionIn { get; set; } = "fadeInUp";
        [Parameter]
        [ValidateSet("bounceInLeft", "bounceInRight", "bounceInUp", "bounceInDown", "fadeIn", "fadeInDown", "fadeInUp", "fadeInLeft", "fadeInRight", "flipInX")]
        public string TransitionOut { get; set; } = "fadeOut";
        [Parameter()]
        public SwitchParameter Broadcast { get; set; }
        protected override void EndProcessing()
        {
            try 
            {
                var options = new {
                    close = !HideCloseButton.IsPresent,
                    id = Id,
                    message = Message, 
                    messageColor = MessageColor?.HtmlColor,
                    messageSize = MessageSize,
                    title = Title,
                    titleColor = TitleColor?.HtmlColor,
                    titleSize = TitleSize,
                    timeout = Duration,
                    position = Position,
                    backgroundColor = BackgroundColor?.HtmlColor,
                    theme = Theme,
                    icon = Icon == FontAwesomeIcons.None ? "" : $"fa fa-{Icon.ToString().Replace("_", "-")}",
                    iconColor = IconColor?.HtmlColor,
                    displayMode = ReplaceToast.IsPresent ? 2 : 0,
                    rtl = RightToLeft.IsPresent,
                    balloon = Balloon.IsPresent,
                    overlay = Overlay.IsPresent,
                    overlayClose = OverlayClose.IsPresent,
                    overlayColor = OverlayColor?.HtmlColor,
                    closeOnClick = CloseOnClick.IsPresent,
                    CloseOnEscape = CloseOnEscape.IsPresent,
                    transitionIn = TransitionIn,
                    transitionOut = TransitionOut
                };

                var hub = this.GetVariableValue("DashboardHub") as IHubContext<DashboardHub>;
                if (Broadcast.IsPresent) {
                    hub.ShowToast(options).Wait();
                } else {    
                    var connectionId = this.GetVariableValue("ConnectionId") as string;   
                    hub.ShowToast(connectionId, options).Wait();
                }
            }
            catch (Exception ex) {
                 Log.Error(ex.Message);
            }
		}
	}
}
