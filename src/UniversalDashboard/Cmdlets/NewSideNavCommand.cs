using System.Linq;
using System.Management.Automation;
using UniversalDashboard.Models;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDSideNav")]
    public class NewSideNavCommand : ComponentCmdlet
    {
        [Parameter(ParameterSetName = "Endpoint", Mandatory = true)]
        public object Endpoint { get; set; }

        [Parameter(ParameterSetName = "Content", Mandatory = true)]
        public ScriptBlock Content { get; set; }

        [Parameter(ParameterSetName = "None", Mandatory = true)]
        public SwitchParameter None { get; set; }

        [Parameter()]
        public SwitchParameter Fixed { get; set; }

        [Parameter()]
        public int Width { get; set; } = 300;

        protected override void BeginProcessing()
        {
            var sideNav = new SideNav
            {
                Id = Id,
                Fixed = Fixed.IsPresent,
                None = None.IsPresent,
                Callback = Endpoint.TryGenerateEndpoint(Id, SessionState),
                Width = Width
            };

            sideNav.Content = GetItemsFromScriptBlock<SideNavItem>(Content)?.ToArray();
            if (sideNav.Content != null)
            {
                sideNav.ChildEndpoints = sideNav.Content.Where(m => m.HasCallback).Select(m => m.Callback).ToArray();
            }

            WriteObject(sideNav);
        }
    }

    [Cmdlet(VerbsCommon.New, "UDSideNavItem")]
    public class NewSidNavItemCommand : ComponentCmdlet
    {
        [Parameter(ParameterSetName = "Divider")]
        public SwitchParameter Divider { get; set; }

        [Parameter(ParameterSetName = "SubHeader")]
        public SwitchParameter SubHeader { get; set; }

        [Parameter(ParameterSetName = "SubHeader")]
        public ScriptBlock Children { get; set; }

        [Parameter(ParameterSetName = "Url")]
        [Alias("PageName")]
        public string Url { get; set; }

        [Parameter(ParameterSetName = "SubHeader")]
        [Parameter(ParameterSetName = "Url")]
        [Parameter(ParameterSetName = "OnClick")]
        public string Text { get; set; }

        [Parameter(ParameterSetName = "SubHeader")]
        [Parameter(ParameterSetName = "Url")]
        [Parameter(ParameterSetName = "OnClick")]
        public FontAwesomeIcons Icon { get; set; }

        [Parameter(ParameterSetName = "OnClick")]
        public object OnClick { get; set; }

        protected override void BeginProcessing()
        {
            WriteObject(new SideNavItem
            {
                Id = Id,
                Divider = Divider.IsPresent,
                SubHeader = SubHeader.IsPresent,
                Children = GetItemsFromScriptBlock<SideNavItem>(Children)?.ToArray(),
                Text = Text,
                Url = Url,
                Icon = Icon.GetIconName(),
                Callback = OnClick.TryGenerateEndpoint(Id, SessionState)
            });
        }
    }
}
