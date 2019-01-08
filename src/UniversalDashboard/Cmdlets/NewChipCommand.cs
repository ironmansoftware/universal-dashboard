using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using System.Linq;
using System.Collections.ObjectModel;
using System;
using System.Collections;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDChip", DefaultParameterSetName = "Icon")]
    public class NewChipCommand : ComponentCmdlet, IDynamicParameters
    {
        [Parameter(Position = 0)]
        public string Label { get; set; }

        [Parameter(Position = 8)]
        public ScriptBlock OnDelete { get; set; }

        [Parameter(Position = 7)]
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

            var hashtable = new Hashtable();
            foreach(var boundParameter in MyInvocation.BoundParameters)
            {
                if (boundParameter.Key.EndsWith("Binding"))
                {
                    var key = boundParameter.Key.Replace("Binding", string.Empty);
                    key = char.ToLowerInvariant(key[0]) + key.Substring(1);
                    hashtable.Add(key, boundParameter.Value);
                }
            }

            if (hashtable.Count > 0)
            {
                chip.ViewModelBinding = new ViewModelBinding("root", hashtable);
            }


            Log.Debug(JsonConvert.SerializeObject(chip));

            WriteObject(chip);
        }

        public object GetDynamicParameters()
        {
            var parameters = this.GetType().GetProperties().Where(m => m.GetCustomAttributes(typeof(ParameterAttribute), false).Any());

            var parameterDictionary = new RuntimeDefinedParameterDictionary();
            foreach(var parameter in parameters)
            {
                var bindingParameter = new ParameterAttribute();
                var attributeCollection = new Collection<Attribute>();
                attributeCollection.Add(bindingParameter);
                var runtimeDefinedParameter = new RuntimeDefinedParameter(parameter.Name + "Binding", typeof(string), attributeCollection);
                parameterDictionary.Add(parameter.Name + "Binding", runtimeDefinedParameter);
            }

            return parameterDictionary;
        }
    }
}
