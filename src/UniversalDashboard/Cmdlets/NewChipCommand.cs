using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDChip", DefaultParameterSetName = "Icon")]
    public class NewChipCommand : ComponentCmdlet
    {
        [Parameter(Position = 0)]
        public string Label { get; set; }

        [Parameter(Position = 8)]
        public ScriptBlock OnDelete { get; set; }

        [Parameter(Position = 7)]
        public ScriptBlock OnClick { get; set; }

        [Parameter(Position = 1, ParameterSetName = "Icon")]
        [Parameter(Position = 1, ParameterSetName = "Binding")]
        public FontAwesomeIcons Icon { get; set; }

        [Parameter(Position = 2)]
        [ValidateSet("default", "primary", "secondary")]
        public string Color { get; set; } = "default";

        [Parameter(Position = 3)]
        [ValidateSet("outlined", "default")]
        public string Style { get; set; } = "default";

        [Parameter(Position = 4)]
        public SwitchParameter Clickable { get; set; }

        [Parameter(Position = 5, ParameterSetName = "Avatar")]
        [Parameter(Position = 5, ParameterSetName = "Binding")]
        public string Avatar { get; set; }

        [Parameter(Position = 6, ParameterSetName = "Avatar")]
        [Parameter(Position = 6, ParameterSetName = "Binding")]
        [ValidateSet("letter", "image")]
        public string AvatarType { get; set; }

        [Parameter(ParameterSetName = "Binding", Mandatory = true)]
        public ViewModelBinding ViewModelBinding { get; set; }

        private readonly Logger Log = LogManager.GetLogger(nameof(NewChipCommand));

        protected override void BeginProcessing()
        {
            var Delete = false;
            if (OnDelete != null)
            {
                Delete = true;
            };

            var chip = new Chip();
            chip.Id = Id;
            chip.Label = Label;
            chip.Icon = FontAwesomeIconsExtensions.GetIconName(Icon);
            chip.Color = Color;
            chip.Style = Style;
            chip.Clickable = Clickable;
            chip.OnClick = OnClick.GenerateCallback(Id + "onClick", SessionState);
            chip.OnDelete = OnDelete.GenerateCallback(Id + "onDelete", SessionState);
            chip.Delete = Delete;
            chip.Avatar = Avatar;
            chip.AvatarType = AvatarType;
            chip.ViewModelBinding = ViewModelBinding;

            Log.Debug(JsonConvert.SerializeObject(chip));

            WriteObject(chip);
        }
    }
}
