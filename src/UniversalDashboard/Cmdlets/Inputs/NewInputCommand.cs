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

		[Parameter()]
		public SwitchParameter DebugEndpoint { get; set; }

		protected Endpoint GenerateCallback()
		{
			var logger = LogManager.GetLogger("NewInputCommand");

			var callback = new Endpoint();
			callback.ScriptBlock = Endpoint;
			callback.Debug = DebugEndpoint;

			try
			{
				var variables = SessionState.InvokeCommand.InvokeScript("Get-Variable")
										  .Select(m => m.BaseObject)
										  .OfType<PSVariable>()
										  .Where(m => m.GetType().Name != "LocalVariable" &&
												 m.GetType().Name != "SessionStateCapacityVariable" &&
												 m.GetType().Name != "NullVariable" &&
												 m.GetType().Name != "QuestionMarkVariable" &&
												 !((m.Options & ScopedItemOptions.AllScope) == ScopedItemOptions.AllScope || (m.Options & ScopedItemOptions.Constant) == ScopedItemOptions.Constant || (m.Options & ScopedItemOptions.ReadOnly) == ScopedItemOptions.ReadOnly))
										  .Select(m => new KeyValuePair<string, object>(m.Name, SessionState.PSVariable.GetValue(m.Name)))
										  .ToArray();

				callback.Variables = new Dictionary<string, object>();
				foreach (var variable in variables)
					callback.Variables.Add(variable.Key, variable.Value);

				callback.Modules = SessionState.InvokeCommand.InvokeScript("Get-Module")
														.Select(m => m.BaseObject)
														.OfType<PSModuleInfo>()
														.Select(m => m.Path)
														.ToList();
			}
			catch (Exception ex)
			{
				logger.Error(ex, "Failed to look up variables.");
			}


			return callback;
		}

		private IEnumerable<Field> GetFieldsFromParamBlock() {

			var paramBlock = (ParamBlockAst)Endpoint.Ast.Find(m => m is ParamBlockAst, false);

			var fields = new List<Field>();
			foreach(var parameter in paramBlock.Parameters)
			{
				var parameterAttribute = parameter.Attributes.OfType<AttributeAst>().FirstOrDefault(m => m.TypeName.Name == "Parameter");
				var validateSetAttribute = parameter.Attributes.OfType<AttributeAst>().FirstOrDefault(m => m.TypeName.Name == "ValidateSet");
				var stringConstant = parameterAttribute?.NamedArguments?.FirstOrDefault(m => m.ArgumentName.Equals("HelpMessage", StringComparison.OrdinalIgnoreCase))?.Argument as StringConstantExpressionAst;
				
				var field = new Field();
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
				Callback = GenerateCallback(),
				Title = Title,
				BackgroundColor = BackgroundColor?.HtmlColor,
				FontColor = FontColor?.HtmlColor,
				SubmitText = SubmitText,
				Fields = new Field[0]
			};

			if (Content == null) 
			{
				input.Fields = GetFieldsFromParamBlock().ToArray();
			}
			else 
			{
				var fields = Content.Invoke().Select(m => m.BaseObject).OfType<Field>().ToArray();
				input.Fields = fields;
			}

			Log.Debug(JsonConvert.SerializeObject(input));

			WriteObject(input);
		}
	}
}
