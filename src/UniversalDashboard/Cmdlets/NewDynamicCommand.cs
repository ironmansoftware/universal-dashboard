using System;
using System.Collections.Generic;
using System.Management.Automation;
using UniversalDashboard.Cmdlets;

namespace UniversalDashboard 
{
    [Cmdlet(VerbsCommon.New, "UDDynamic")]
    public class NewDynamicCommand : PSCmdlet 
    {
        [Parameter]
        public string Id { get; set; } = Guid.NewGuid().ToString();
        [Parameter]
        public object[] ArgumentList { get; set; }
        [Parameter(Position = 0)]
        public ScriptBlock Content { get; set; }
        [Parameter]
        public SwitchParameter AutoRefresh { get; set; }
        [Parameter]
        public int AutoRefreshInterval { get; set; } = 10;

        protected override void EndProcessing() 
        {
            Content.GenerateCallback(Id, this, this.SessionState, ArgumentList);

            WriteObject(new Dictionary<string, object> {
                { "id", Id },
                { "autoRefresh", AutoRefresh.IsPresent },
                { "autoRefreshInterval", AutoRefreshInterval},
                { "type", "dynamic"},
                { "isPlugin", true }
            });
        }
    }
}