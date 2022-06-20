using System.Collections.Generic;
using System.Management.Automation;

namespace UniversalDashboard.Enterprise
{
    [Cmdlet(VerbsCommon.New, "UDNivoChartAxisOptions")]
    public class NewNivoChartAxisOptionsCommand : PSCmdlet
    {
        private readonly Dictionary<string, object> _values = new Dictionary<string, object>();

        [Parameter]
        [ValidateSet("top", "right", "bottom", "left")]
        public string Position
        {
            set
            {
                _values.Add("orient", value);
            }
        }


        [Parameter]
        public int TickSize
        {
            set
            {
                _values.Add("tickSize", value);
            }
        }

        [Parameter]
        public int TickPadding
        {
            set
            {
                _values.Add("tickPadding", value);
            }
        }

        [Parameter]
        public int TickRotation
        {
            set
            {
                _values.Add("tickRotation", value);
            }
        }

        [Parameter]
        public string Legend
        {
            set
            {
                _values.Add("legend", value);
            }
        }

        [Parameter]
        [ValidateSet("center", "start", "end")]
        public string LegendPosition
        {
            set
            {
                _values.Add("legendPosition", value);
            }
        }

        [Parameter]
        public int LegendOffset
        {
            set
            {
                _values.Add("legendOffset", value);
            }
        }

        protected override void EndProcessing() {
            WriteObject(_values);
        }
    }
}
