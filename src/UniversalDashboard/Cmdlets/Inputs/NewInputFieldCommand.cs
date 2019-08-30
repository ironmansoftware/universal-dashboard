using NLog;
using UniversalDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Language;
using Newtonsoft.Json;

namespace UniversalDashboard.Cmdlets.Inputs
{
    [Cmdlet(VerbsCommon.New, "UDInputField")]
    public class NewInputFieldCommand : PSCmdlet
    {
        [Parameter(Mandatory = true)]
        public string Name { get; set; }

        //[Parameter()]
        public SwitchParameter Mandatory { get; set; }

        [Parameter()]
        public object[] Values { get; set; }

        [Parameter()]
        public object DefaultValue { get; set; }

        [Parameter()]
        public string[] Placeholder { get; set; }

        [Parameter()]
        [ValidateSet("textbox", "checkbox", "select", "radioButtons", "password", "textarea", "switch", "date", "file", "time", "binaryFile")]
        public string Type { get; set; }

        [Parameter(ParameterSetName = "datetime")]
        public string OkText { get; set; } = "Ok";

        [Parameter(ParameterSetName = "datetime")]
        public string CancelText { get; set; } = "Cancel";

        [Parameter(ParameterSetName = "datetime")]
        public string ClearText { get; set; } = "Clear";


        private readonly Logger Log = LogManager.GetLogger(nameof(NewInputFieldCommand));
		protected override void EndProcessing()
		{
            if (Type == "select" && (null == DefaultValue || DefaultValue.ToString() == "") && (null != Values && Values.Count() >= 0))
            {
                DefaultValue = Values[0];
            }
			var field = new Field
			{
				Name = Name,
                Required = Mandatory,
				ValidOptions = Values,
				Value = DefaultValue,
                Placeholder = Placeholder,
                Type = Type,
                OkText = OkText,
                CancelText = CancelText,
                ClearText = ClearText
			};

			Log.Debug(JsonConvert.SerializeObject(field));

			WriteObject(field);
		}
	}
}
