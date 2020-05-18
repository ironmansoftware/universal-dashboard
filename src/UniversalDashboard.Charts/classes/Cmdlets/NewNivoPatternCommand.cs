using System.Collections.Generic;
using System.Management.Automation;

namespace UniversalDashboard.Enterprise.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDNivoPattern")]
    public class NewNivoPatternCommand : PSCmdlet
    {
        private readonly Dictionary<string, object> _values = new Dictionary<string, object>();

        [Parameter(Mandatory = true)]
        public string Id
        {
            set
            {
                _values.Add("id", value);
            }
        }

        [Parameter(Mandatory = true, ParameterSetName = "dots")]
        public SwitchParameter Dots
        {
            set
            {
                _values.Add("type", "patternDots");
            }
        }

        [Parameter(Mandatory = true, ParameterSetName = "lines")]
        public SwitchParameter Lines
        {
            set
            {
                _values.Add("type", "patternLines");
            }
        }

        [Parameter(Mandatory = true, ParameterSetName = "squares")]
        public SwitchParameter Squares
        {
            set
            {
                _values.Add("type", "pattenSquares");
            }
        }

        [Parameter(ParameterSetName = "dots")]
        [Parameter(ParameterSetName = "squares")]
        public int Size
        {
            set
            {
                _values.Add("size", value);
            }
        }

        [Parameter(ParameterSetName = "dots")]
        [Parameter(ParameterSetName = "squares")]
        public int Padding
        {
            set
            {
                _values.Add("padding", value);
            }
        }

        [Parameter(ParameterSetName = "dots")]
        [Parameter(ParameterSetName = "squares")]
        public SwitchParameter Stagger
        {
            set
            {
                _values.Add("stagger", true);
            }
        }

        [Parameter]
        public string Background
        {
            set
            {
                _values.Add("background", value);
            }
        }

        [Parameter]
        public string Color
        {
            set
            {
                _values.Add("color", value);
            }
        }

        protected override void EndProcessing()
        {
            WriteObject(_values);
        }

        [Parameter(ParameterSetName = "lines")]
        public int Spacing
        {
            set
            {
                _values.Add("spacing", value);
            }
        }

        [Parameter(ParameterSetName = "lines")]
        public int Rotation
        {
            set
            {
                _values.Add("rotation", value);
            }
        }

        [Parameter(ParameterSetName = "lines")]
        public int LineWidth
        {
            set
            {
                _values.Add("lineWidth", value);
            }
        }
    }
}
