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
    public class NewTreeViewCommand : CallbackCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewTreeNodeCommand));

        [Parameter(Mandatory = true)]
		public TreeNode Node  { get; set; }

		[Parameter]
		public ScriptBlock OnNodeClicked { get; set; }

		protected override void EndProcessing()
		{
			WriteObject(new TreeView {
				Id = Id,
				Callback = GenerateCallback(Id, OnNodeClicked),
                Node = Node
            });
		}
	}
}
