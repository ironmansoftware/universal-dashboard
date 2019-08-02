using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using System.Collections;
using UniversalDashboard.Services;
using System.Linq;
using System;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDTreeNode")]
    public class NewTreeNodeCommand : PSCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewTreeNodeCommand));

		[Parameter(Mandatory = true, Position = 1)]
		public string Name { get; set; }
		[Parameter()]
		public string Id { get; set; }
        [Parameter]
		public ScriptBlock Children  { get; set; }
		[Parameter]
		public FontAwesomeIcons Icon { get; set; }
		protected override void EndProcessing()
		{
			WriteObject(new TreeNode {
				Id = Id,
                Name = Name, 
                Children = Children?.Invoke().Select(m => m.BaseObject).Cast<TreeNode>(),
				Icon = Icon.GetIconName()
            });
		}
	}
}
