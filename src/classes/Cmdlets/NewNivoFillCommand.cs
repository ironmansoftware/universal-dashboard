using System.Collections.Generic;
using System.Management.Automation;

namespace UniversalDashboard.Enterprise.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDNivoFill")]
    public class NewNivoFillCommand : PSCmdlet
    {
        private readonly Dictionary<string, object> _values = new Dictionary<string, object>();

        [Parameter(Mandatory = true)]
        public string ElementId { get; set; }

        [Alias("GradientId")]
        [Parameter(Mandatory = true)]
        public string PatternId { get; set; }

        protected override void BeginProcessing()
        {
            WriteObject(new Dictionary<string, object>
            {
                { "match", new Dictionary<string, object> {
                    {  "id", ElementId }
                }
                },
                { "id", PatternId }
            });
        }
    }
}
