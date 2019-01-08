using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDChip", DefaultParameterSetName = "Icon")]
    public class NewChipCommand : BindableComponentCmdlet
    {
        [Parameter(Position = 0)]
        public string Label { get; set; }

        [Parameter(Position = 8)]
        [Endpoint]
        public ScriptBlock OnDelete { get; set; }

        [Parameter(Position = 7)]
        [Endpoint]
        public ScriptBlock OnClick { get; set; }

        [Parameter(Position = 1, ParameterSetName = "Icon")]
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
        public string Avatar { get; set; }

        [Parameter(Position = 6, ParameterSetName = "Avatar")]
        [ValidateSet("letter", "image")]
        public string AvatarType { get; set; }
        
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
            chip.ViewModelBinding = GetViewModelBinding();

            Log.Debug(JsonConvert.SerializeObject(chip));

            WriteObject(chip);
        }
    }
}
