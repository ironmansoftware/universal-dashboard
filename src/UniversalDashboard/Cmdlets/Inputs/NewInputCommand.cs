using NLog;
using UniversalDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Language;
using Newtonsoft.Json;
using System.Security;

namespace UniversalDashboard.Cmdlets.Inputs
{
	[Cmdlet(VerbsCommon.New, "UDInput")]
    public class NewInputCommand : ComponentCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewInputCommand));

		[Parameter]
		public string Title { get; set; }

		[Parameter]
		public string SubmitText { get; set; } = "Submit";

		[Parameter]
		public DashboardColor BackgroundColor { get; set; }

		[Parameter]
		public DashboardColor FontColor { get; set; }

		[Parameter(Mandatory = true)]
		public ScriptBlock Endpoint { get; set; }

		[Parameter()]
		public ScriptBlock Content { get; set; }

        [Parameter]
        public SwitchParameter Validate { get; set; }
        [Parameter]
        public object[] ArgumentList { get; set; }

        private IEnumerable<Field> GetFieldsFromParamBlock() {

			var paramBlock = (ParamBlockAst)Endpoint.Ast.Find(m => m is ParamBlockAst, false);
			var fields = new List<Field>();

            if (paramBlock == null)
            {
                return fields;
            }

			foreach(var parameter in paramBlock.Parameters)
			{
				var parameterAttribute = parameter.Attributes.OfType<AttributeAst>().FirstOrDefault(m => m.TypeName.Name == "Parameter");
				var validateSetAttribute = parameter.Attributes.OfType<AttributeAst>().FirstOrDefault(m => m.TypeName.Name == "ValidateSet");
                var stringConstant = parameterAttribute?.NamedArguments?.FirstOrDefault(m => m.ArgumentName.Equals("HelpMessage", StringComparison.OrdinalIgnoreCase))?.Argument as StringConstantExpressionAst;
                
                var field = new Field();
                
                if (Validate)
                {
                    var validateErrorMessageAttribute = parameter.Attributes.OfType<AttributeAst>().FirstOrDefault(m => m.TypeName.Name.Equals("UniversalDashboard.ValidationErrorMessage", StringComparison.OrdinalIgnoreCase));
                    var validateErrorMessage = validateErrorMessageAttribute?.PositionalArguments.FirstOrDefault() as StringConstantExpressionAst;
                    var mandatoryProperty = parameterAttribute?.NamedArguments?.FirstOrDefault(m => m.ArgumentName.Equals("Mandatory", StringComparison.OrdinalIgnoreCase))?.Argument;
                    var isMandatory = (bool?)mandatoryProperty?.SafeGetValue() == true;

                    var endpoint = new Endpoint(ScriptBlock.Create($"param({parameter.ToString()})"));
                    endpoint.Name = Guid.NewGuid().ToString();
                    endpoint.SessionId = SessionId;

                    var hostState = this.GetHostState();
                    hostState.EndpointService.Register(endpoint);

                    field.Required = isMandatory;
                    field.Endpoint = endpoint;
                    field.ValidationEndpoint = endpoint.Name;
                    field.ValidationErrorMessage = validateErrorMessage?.Value;
                }

				var placeholder = stringConstant?.Value;
				if (placeholder != null)
					field.Placeholder = new string[] {placeholder};
                
				field.Name = parameter.Name.VariablePath.ToString();

                if (parameter.StaticType == typeof(bool) || parameter.StaticType == typeof(SwitchParameter))
                {
                    field.Type = FieldTypes.Checkbox;
                    field.Value = "false";
                    field.DotNetType = parameter.StaticType.FullName;
                }
                else if (parameter.StaticType.IsEnum)
                {
                    field.Type = FieldTypes.Select;
                    field.ValidOptions = Enum.GetNames(parameter.StaticType);
                    field.DotNetType = parameter.StaticType.FullName;
                    field.Value = Enum.GetValues(parameter.StaticType).GetValue(0)?.ToString();
                }
                else if (parameter.StaticType == typeof(DateTime))
                {
                    field.Type = FieldTypes.Date;
                    field.DotNetType = parameter.StaticType.FullName;
                }
                else if (parameter.StaticType == typeof(SecureString))
                {
                    field.Type = FieldTypes.Password;
                    field.DotNetType = parameter.StaticType.FullName;
                }
                else if (parameter.StaticType == typeof(String[]))
                {
                    field.Type = FieldTypes.Textarea;
                    field.DotNetType = parameter.StaticType.FullName;
                }
                else
                {
                    field.Type = FieldTypes.Textbox;
                    field.DotNetType = typeof(string).FullName;

                    if (validateSetAttribute != null)
                    {
                        field.ValidOptions = validateSetAttribute?.PositionalArguments.OfType<StringConstantExpressionAst>().Select(m => m.Value).ToArray();
                        field.Type = FieldTypes.Select;
                        field.Value = field.ValidOptions[0]?.ToString();
                    }
                }

				fields.Add(field);
			}
			return fields;
		}

		protected override void EndProcessing()
		{
			var input = new Input
			{
				Id = Id,
				Callback = Endpoint.GenerateCallback(Id, this, SessionState, ArgumentList),
				Title = Title,
				BackgroundColor = BackgroundColor?.HtmlColor,
				FontColor = FontColor?.HtmlColor,
				SubmitText = SubmitText,
				Fields = new Field[0],
                Validate = Validate
			};

			if (Content == null) 
			{
				input.Fields = GetFieldsFromParamBlock().ToArray();
			}
			else 
			{
				var fields = Content.Invoke().Select(m => m.BaseObject).OfType<Field>().ToArray();
				input.Fields = fields;

                var paramBlockFields = GetFieldsFromParamBlock().ToArray();
                foreach(var field in paramBlockFields)
                {
                    var contentField = input.Fields.FirstOrDefault(m => m.Name.Equals(field.Name, StringComparison.OrdinalIgnoreCase));
                    if (contentField != null)
                    {
                        contentField.Required = field.Required;
                        contentField.Endpoint = field.Endpoint;
                        contentField.ValidationEndpoint = field.ValidationEndpoint;
                        contentField.ValidationErrorMessage = field.ValidationErrorMessage;
                    }
                }
			}

			Log.Debug(JsonConvert.SerializeObject(input));

			WriteObject(input);
		}
	}
}
