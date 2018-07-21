using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using System.Collections;
using UniversalDashboard.Services;
using System.Linq;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDTreeView")]
    public class NewTreeViewCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewTreeNodeCommand));

        [Parameter(Mandatory = true)]
		public TreeNode Node  { get; set; }

		protected override void EndProcessing()
		{
			WriteObject(new TreeView {
                Node = Node
            });
		}
	}
}
