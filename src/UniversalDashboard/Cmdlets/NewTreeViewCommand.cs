using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using System.Collections;
using UniversalDashboard.Services;
using System.Linq;
using System.Drawing;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDTreeView")]
    public class NewTreeViewCommand : CallbackCmdlet
    {
        private readonly Logger Log = LogManager.GetLogger(nameof(NewTreeNodeCommand));

        [Parameter(Mandatory = true)]
        public TreeNode Node { get; set; }

        [Parameter]
        public object OnNodeClicked { get; set; }

        [Parameter]
        public DashboardColor BackgroundColor { get; set; } = new DashboardColor(Color.White);

        [Parameter]
        public DashboardColor FontColor { get; set; } = new DashboardColor(Color.Black);

        [Parameter]
        public DashboardColor ActiveBackgroundColor { get; set; } = new DashboardColor(0xDFE8E4);

        [Parameter]
        public DashboardColor ToggleColor { get; set; } = new DashboardColor(Color.Black);

        protected override void EndProcessing()
        {
            Endpoint callback = null;

            var scriptBlock = OnNodeClicked as ScriptBlock;
            if (scriptBlock != null)
            {
                callback = GenerateCallback(Id, scriptBlock, null);
            }
            else
            {
                var psobject = OnNodeClicked as PSObject;
                callback = psobject?.BaseObject as Endpoint;

            }

            WriteObject(new TreeView
            {
                Id = Id,
                Callback = callback,
                Node = Node,
                ToggleColor = ToggleColor?.HtmlColor,
                BackgroundColor = BackgroundColor?.HtmlColor,
                FontColor = FontColor?.HtmlColor,
                ActiveBackgroundColor = ActiveBackgroundColor?.HtmlColor
            });
        }
    }
}
