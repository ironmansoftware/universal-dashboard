using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.Security.Cryptography;
using System.Text;

namespace UniversalDashboard.Enterprise
{
    [Cmdlet(VerbsCommon.New, "UDNivoChart")]
    public class NewNivoChartCommand : PSCmdlet
    {
        public static string AssetId { get; set; }

        private readonly Hashtable _values = new Hashtable();
        private readonly Hashtable _margin = new Hashtable();
        private readonly Hashtable _xScale = new Hashtable();
        private readonly Hashtable _yScale = new Hashtable();

        #region Common

        [Parameter]
        public string Id { get; set; } = Guid.NewGuid().ToString();
        [Parameter(Mandatory = true)]
        public object Data
        {
            set
            {
                if (value is string str)
                {
                    var jobject = JsonConvert.DeserializeObject<JObject>(str);
                    _values.Add("data", jobject);
                }
                else
                {
                    _values.Add("data", value);
                }
            }
        }

        [Parameter]
        public object Definitions
        {
            set
            {
                var val = value;
                if (val is IEnumerable enumerable && !(val is string))
                {
                    var items = new ArrayList();
                    foreach (var item in enumerable)
                    {
                        items.Add(item);
                    }
                    val = items;

                    _values.Add("defs", val);
                    return;
                }

                _values.Add("defs", new[] { val });
            }
        }

        [Parameter]
        public object Fill
        {
            set
            {
                var val = value;
                if (val is IEnumerable enumerable && !(val is string))
                {
                    var items = new ArrayList();
                    foreach (var item in enumerable)
                    {
                        items.Add(item);
                    }
                    val = items;

                    _values.Add("fill", val);
                    return;
                }

                _values.Add("fill", new[] { val });
            }
        }

        [Parameter]
        public Hashtable Theme {
            set 
            {
                _values.Add("theme", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Pie")]
        [Parameter(ParameterSetName = "Stream")]
        [Parameter(ParameterSetName = "Treemap")]
        public int BorderWidth
        {
            set
            {
                _values.Add("borderWidth", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Pie")]
        [Parameter(ParameterSetName = "Stream")]
        [Parameter(ParameterSetName = "Treemap")]
        public string BorderColor
        {
            set
            {
                _values.Add("borderColor", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        public string IndexBy
        {
            set
            {
                _values.Add("indexBy", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        public int MinValue
        {
            set
            {
                _values.Add("minValue", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        public int MaxValue
        {
            set
            {
                _values.Add("maxValue", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        public float Padding
        {
            set
            {
                _values.Add("padding", value);
            }
        }

        [Parameter]
        public SwitchParameter Responsive
        {
            set
            {
                _values.Add("responsive", true);
            }
        }

        [Parameter]
        public int Width
        {
            set
            {
                _values.Add("width", value);
            }
        }

        [Parameter]
        public int Height
        {
            set
            {
                _values.Add("height", value);
            }
        }

        [Parameter]
        public object Colors
        {
            set
            {
                _values.Add("colors", value);
            }
        }

        [Parameter]
        public object ColorBy
        {
            set
            {
                _values.Add("colorBy", value);
            }
        }

        [Parameter]
        public SwitchParameter UseDataColor
        {
            set
            {
                _values.Add("useDataColor", true);
            }
        }


        [Parameter]
        public SwitchParameter DisableInteractive
        {
            set
            {
                _values.Add("isInteractive", false);
            }
        }


        [Parameter]
        public object OnClick
        {
            get;set;
        }

        [Parameter]
        public int MarginTop
        {
            set
            {
                _margin.Add("top", value);
                if (_values.ContainsKey("margin"))
                {
                    _values["margin"] = _margin;
                }
                else
                {
                    _values.Add("margin", _margin);
                }
            }
        }

        [Parameter]
        public int MarginBottom
        {
            set
            {
                _margin.Add("bottom", value);
                if (_values.ContainsKey("margin"))
                {
                    _values["margin"] = _margin;
                }
                else
                {
                    _values.Add("margin", _margin);
                }
            }
        }

        [Parameter]
        public int MarginLeft
        {
            set
            {
                _margin.Add("left", value);
                if (_values.ContainsKey("margin"))
                {
                    _values["margin"] = _margin;
                }
                else
                {
                    _values.Add("margin", _margin);
                }
            }
        }

        [Parameter]
        public int MarginRight
        {
            set
            {
                _margin.Add("right", value);
                if (_values.ContainsKey("margin"))
                {
                    _values["margin"] = _margin;
                }
                else
                {
                    _values.Add("margin", _margin);
                }
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        public int LabelSkipWidth
        {
            set
            {
                _values.Add("labelSkipWidth", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        public int LabelSkipHeight
        {
            set
            {
                _values.Add("labelSkipHeight", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        public string LabelTextColor
        {
            set
            {
                _values.Add("labelTextColor", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        [Parameter(ParameterSetName = "Stream")]
        [Parameter(ParameterSetName = "Line")]
        public SwitchParameter EnableGridX
        {
            set
            {
                _values.Add("enableGridX", true);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        [Parameter(ParameterSetName = "Stream")]
        [Parameter(ParameterSetName = "Line")]
        public object[] GridXValues
        {
            set
            {
                _values.Add("gridXValues", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        [Parameter(ParameterSetName = "Stream")]
        [Parameter(ParameterSetName = "Line")]
        public SwitchParameter EnableGridY
        {
            set
            {
                _values.Add("enableGridY", true);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        [Parameter(ParameterSetName = "Stream")]
        [Parameter(ParameterSetName = "Line")]
        public object[] GridYValues
        {
            set
            {
                _values.Add("girdYValues", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        [Parameter(ParameterSetName = "Stream")]
        public SwitchParameter DisableAnimations
        {
            set
            {
                _values.Add("disableAnimations", true);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        [Parameter(ParameterSetName = "Stream")]
        public int MotionStiffness
        {
            set
            {
                _values.Add("motionStiffness", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Heatmap")]
        [Parameter(ParameterSetName = "Stream")]
        public int MotionDamping
        {
            set
            {
                _values.Add("motionDamping", value);
            }
        }

        [Parameter(ParameterSetName = "Bar", Mandatory = true)]
        [Parameter(ParameterSetName = "Heatmap")]
        [Parameter(ParameterSetName = "Stream")]
        public string[] Keys
        {
            set
            {
                _values.Add("keys", value);
            }
        }


        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Line")]
        public string[] Layers
        {
            set
            {
                _values.Add("layers", value);
            }
        }

        [Parameter(ParameterSetName = "Stream")]
        [Parameter(ParameterSetName = "Line")]
        public int DotSize
        {
            set
            {
                _values.Add("dotSize", value);
            }
        }

        [Parameter(ParameterSetName = "Stream")]
        [Parameter(ParameterSetName = "Line")]
        public int DotBorderWidth
        {
            set
            {
                _values.Add("dotBorderWidth", value);
            }
        }

        [Parameter(ParameterSetName = "Stream")]
        [Parameter(ParameterSetName = "Line")]
        public SwitchParameter DisableStackTooltip
        {
            set
            {
                _values.Add("enableStackTooltip", false);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Line")]
        [Parameter(ParameterSetName = "Stream")]
        public object AxisTop
        {
            set
            {
                _values.Add("axisTop", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Line")]
        [Parameter(ParameterSetName = "Stream")]
        public object AxisBottom
        {
            set
            {
                _values.Add("axisBottom", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Line")]
        [Parameter(ParameterSetName = "Stream")]
        public object AxisLeft
        {
            set
            {
                _values.Add("axisLeft", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Line")]
        [Parameter(ParameterSetName = "Stream")]
        public object AxisRight
        {
            set
            {
                _values.Add("axisRight", value);
            }
        }

        #endregion

        #region Bar

        [Parameter(ParameterSetName = "Bar")]
        public SwitchParameter Bar
        {
            set
            {
                _values.Add("type", "nivo-bar");
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [ValidateSet("grouped", "stacked")]
        public string GroupMode
        {
            set
            {
                _values.Add("groupMode", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [ValidateSet("vertical", "horizontal")]
        public string Layout
        {
            set
            {
                _values.Add("layout", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        public SwitchParameter Reverse
        {
            set
            {
                _values.Add("reverse", true);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Treemap")]
        public float InnerPadding
        {
            set
            {
                _values.Add("innerPadding", value);
            }
        }

        [Parameter(ParameterSetName = "Bar")]
        public int BorderRadius
        {
            set
            {
                _values.Add("borderRadius", value);
            }
        }


        //TODO: [Parameter(ParameterSetName = "Bar")]
        public object Defs { get; set; }

        

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Treemap")]
        public SwitchParameter DisableLabel
        {
            set
            {
                _values.Add("enableLabel", false);
            }
        }

        #endregion

        #region Calendar 

        [Parameter(Mandatory = true, ParameterSetName = "Calendar")]
        public SwitchParameter Calendar
        {
            set
            {
                _values.Add("type", "nivo-calendar");
            }
        }

        [Parameter(Mandatory = true, ParameterSetName = "Calendar")]
        public DateTime From
        {
            set
            {
                _values.Add("from", value.ToUniversalTime().ToString("u"));
            }
        }

        [Parameter(Mandatory = true, ParameterSetName = "Calendar")]
        public DateTime To
        {
            set
            {
                _values.Add("to", value.ToUniversalTime().ToString("u"));
            }
        }

        [Parameter(ParameterSetName = "Calendar")]
        public object Domain
        {
            set
            {
                _values.Add("domain", value);
            }
        }

        [Parameter(ParameterSetName = "Calendar")]
        public object EmptyColor
        {
            set
            {
                _values.Add("domain", value);
            }
        }

        [Parameter(ParameterSetName = "Calendar")]
        public int YearSpacing
        {
            set
            {
                _values.Add("yearSpacing", value);
            }
        }


        [Parameter(ParameterSetName = "Calendar")]
        public int YearLegendOffset
        {
            set
            {
                _values.Add("yearLegendOffset", value);
            }
        }

        [Parameter(ParameterSetName = "Calendar")]
        public int MonthSpacing
        {
            set
            {
                _values.Add("monthSpacing", value);
            }
        }


        [Parameter(ParameterSetName = "Calendar")]
        public int MonthLegendOffset
        {
            set
            {
                _values.Add("monthLegendOffset", value);
            }
        }


        [Parameter(ParameterSetName = "Calendar")]
        public int DaySpacing
        {
            set
            {
                _values.Add("daySpacing", value);
            }
        }


        [Parameter(ParameterSetName = "Calendar")]
        public int DayLegendOffset
        {
            set
            {
                _values.Add("DayLegendOffset", value);
            }
        }

        #endregion

        #region Heatmap

        [Parameter(ParameterSetName = "Heatmap")]
        public float CellOpacity
        {
            set
            {
                _values.Add("cellOpacity", value);
            }
        }

        [Parameter(ParameterSetName = "Heatmap")]
        public int CellBorderWidth
        {
            set
            {
                _values.Add("cellBorderWidth", value);
            }
        }

        [Parameter(ParameterSetName = "Heatmap")]
        public SwitchParameter Heatmap
        {
            set
            {
                _values.Add("type", "nivo-heatmap");
            }
        }

        [Parameter(ParameterSetName = "Heatmap")]
        public SwitchParameter ForceSquare
        {
            set
            {
                _values.Add("forceSquare", true);
            }
        }

        [Parameter(ParameterSetName = "Heatmap")]
        public int SizeVariation
        {
            set
            {
                _values.Add("sizeVariation", value);
            }
        }

        [Parameter(ParameterSetName = "Heatmap")]
        public SwitchParameter DisableLabels
        {
            set
            {
                _values.Add("enableLabels", false);
            }
        }

        #endregion

        #region Line 

        [Parameter(Mandatory = true, ParameterSetName = "Line")]
        public SwitchParameter Line
        {
            set
            {
                _xScale.Add("type", "point");
                _yScale.Add("type", "linear");

                _values.Add("xScale", _xScale);
                _values.Add("yScale", _yScale);
                _values.Add("type", "nivo-line");
            }
        }

        [Parameter(ParameterSetName = "Line")]
        public int LineWidth
        {
            set
            {
                _values.Add("lineWidth", value);
            }
        }

        [Parameter(ParameterSetName = "Line")]
        public SwitchParameter EnableArea
        {
            set
            {
                _values.Add("enableArea", true);
            }
        }

        [Parameter(ParameterSetName = "Line")]
        public string AreaBaselineValue
        {
            set
            {
                _values.Add("areaBaselineValue", value);
            }
        }

        [Parameter(ParameterSetName = "Line")]
        public float AreaOpacity
        {
            set
            {
                _values.Add("areaOpacity", value);
            }
        }

        [Parameter(ParameterSetName = "Line")]
        public string AreaBlendMode
        {
            set
            {
                _values.Add("areaBlendMode", value);
            }
        }

        [Parameter(ParameterSetName = "Line")]
        public SwitchParameter DisableDots
        {
            set
            {
                _values.Add("enableDots", false);
            }
        }

        [Parameter(ParameterSetName = "Line")]
        public SwitchParameter EnableDotLabel
        {
            set
            {
                _values.Add("enableDotLabel", true);
            }
        }

        [Parameter(ParameterSetName = "Line")]
        public int DotLabelYOffset
        {
            set
            {
                _values.Add("dotLabelYOffset", value);
            }
        }

        [Parameter(ParameterSetName = "Line")]
        public SwitchParameter YScaleStacked
        {
            set
            {
                _yScale.Add("stacked", true);
            }
        }

        [Parameter(ParameterSetName = "Line")]
        public int YScaleMin
        {
            set
            {
                _yScale.Add("min", value);
            }
        }

        [Parameter(ParameterSetName = "Line")]
        public int YScaleMax
        {
            set
            {
                _yScale.Add("max", value);
            }
        }

        #endregion

        #region Pie

        [Parameter(Mandatory = true, ParameterSetName = "Pie")]
        public SwitchParameter Pie
        {
            set
            {
                _values.Add("type", "nivo-pie");
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public int StartAngle
        {
            set
            {
                _values.Add("startAngle", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public int EndAngle
        {
            set
            {
                _values.Add("endAngle", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        [PSDefaultValue(Value = true)]
        public bool Fit
        {
            set
            {
                _values.Add("fit", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public float InnerRadius
        {
            set
            {
                _values.Add("innerRadius", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public int PadAngle
        {
            set
            {
                _values.Add("padAngle", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public int CornerRadius
        {
            set
            {
                _values.Add("cornerRadius", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public SwitchParameter SortByValue
        {
            set
            {
                _values.Add("sortByValue", true);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public SwitchParameter DisableRadiusLabels
        {
            set
            {
                _values.Add("enableRadiusLabels", false);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public int RadiusLabelSkipAngle
        {
            set
            {
                _values.Add("radiusLabelSkipAngle", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public int RadiusLabelsLinkOffset
        {
            set
            {
                _values.Add("radiusLabelsLinkOffset", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public int RadialLabelsLinkDiagonalLength
        {
            set
            {
                _values.Add("radialLabelsLinkDiagonalLength", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public int RadialLabelsLinkHorizontalLength
        {
            set
            {
                _values.Add("radialLabelsLinkHorizontalLength", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public int RadialLabelsTextXOffset
        {
            set
            {
                _values.Add("radialLabelsTextXOffset", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public int RadialLabelsLinkStrokeWidth
        {
            set
            {
                _values.Add("radialLabelsLinkStrokeWidth", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public SwitchParameter DisableSliceLabels
        {
            set
            {
                _values.Add("enableSlicesLabels", false);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public int SlicesLabelsSkipAngle
        {
            set
            {
                _values.Add("slicesLabelsSkipAngle", value);
            }
        }

        [Parameter(ParameterSetName = "Pie")]
        public int SlicesLabelsTextColor
        {
            set
            {
                _values.Add("slicesLabelsTextColor", value);
            }
        }


        #endregion

        #region Stream

        [Parameter(Mandatory = true, ParameterSetName = "Stream")]
        public SwitchParameter Stream
        {
            set
            {
                _values.Add("type", "nivo-stream");
            }
        }

        [Parameter(ParameterSetName = "Stream")]
        public string OffsetType
        {
            set
            {
                _values.Add("offsetType", value);
            }
        }

        [Parameter(ParameterSetName = "Stream")]
        public string Order
        {
            set
            {
                _values.Add("order", value);
            }
        }

        [Parameter(ParameterSetName = "Stream")]
        [Parameter(ParameterSetName = "Line")]
        [ValidateSet("basis", "cardinal", "catmullRom", "linear", "monotoneX", "monotoneY", "natural", "step", "stepAfter", "stepBefore")]
        public string Curve
        {
            set
            {
                _values.Add("curve", value);
            }
        }

        [Parameter(ParameterSetName = "Stream")]
        public float FillOpactiy
        {
            set
            {
                _values.Add("fillOpacity", value);
            }
        }

        [Parameter(ParameterSetName = "Stream")]
        public string DotColor
        {
            set
            {
                _values.Add("dotColor", value);
            }
        }

        #endregion

        #region Treemap 

        [Parameter(ParameterSetName = "Treemap")]
        public SwitchParameter Treemap
        {
            set
            {
                _values.Add("type", "nivo-treemap");
            }
        }

        [Parameter(ParameterSetName = "Treemap")]
        public string Identity
        {
            set
            {
                _values.Add("identity", value);
            }
        }

        [Parameter(ParameterSetName = "Treemap")]
        public string Value
        {
            set
            {
                _values.Add("value", value);
            }
        }

        [Parameter(ParameterSetName = "Treemap")]
        [ValidateSet("squarify", "slice", "dice", "slice-dice")]
        public string Tile
        {
            set
            {
                _values.Add("tile", value);
            }
        }

        [Parameter(ParameterSetName = "Treemap")]
        public SwitchParameter LeavesOnly
        {
            set
            {
                _values.Add("leavesOnly", true);
            }
        }

        [Parameter(ParameterSetName = "Treemap")]
        public int OuterPadding
        {
            set
            {
                _values.Add("outerPadding", value);
            }
        }


        #endregion

        protected override void ProcessRecord()
        {
            if (ParameterSetName == "Treemap")
            {
                _values["root"] = _values["data"];
                _values.Remove("data");
            }

            _values.Add("isPlugin", true);
            _values.Add("assetId", AssetId);
            _values.Add("id", Id);

            if (!_values.ContainsKey("padding")) {
                _values.Add("padding", 0.3);
            }

            if (!_values.ContainsKey("height") && !_values.ContainsKey("width")) {
                if (!_values.ContainsKey("responsive"))
                {
                    _values.Add("responsive", true);
                }
            }
            
            if (!_values.ContainsKey("responsive") && !_values.ContainsKey("width")) {
                _values.Add("width", 700);
            }

            if (!_values.ContainsKey("height")) {
                _values.Add("height", 500);
            }

            if (!_values.ContainsKey("margin")) {
                _values.Add("margin", _margin);
            }

            if (!_margin.ContainsKey("top")) {
                _margin.Add("top", 50);
            }

            if (!_margin.ContainsKey("right")) {
                _margin.Add("right", 130);
            }

            if (!_margin.ContainsKey("bottom")) {
                _margin.Add("bottom", 50);
            }

            if (!_margin.ContainsKey("left")) {
                _margin.Add("left", 60);
            }

            if (OnClick != null) {
                if (OnClick is ScriptBlock scriptBlock)
                {
                    InvokeCommand.InvokeScript($"New-UDEndpoint -Id '{Id}' -Endpoint $args[0] ", true, PipelineResultTypes.None, null, new[] { scriptBlock });
                }

                if (OnClick is PSObject psObject && psObject.BaseObject is ScriptBlock scriptBlock1)
                {
                    InvokeCommand.InvokeScript($"New-UDEndpoint -Id '{Id}' -Endpoint $args[0] ", true, PipelineResultTypes.None, null, new[] { scriptBlock1 });
                }

                _values.Add("hasCallback", true);
            }

            WriteObject(_values);
        }
    }
}
