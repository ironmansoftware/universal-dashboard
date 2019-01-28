using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using UniversalDashboard.Models.Enums;
using UniversalDashboard.Models.Basics;
using System.Collections;
using System.Linq;
using System.Collections.Generic;
using System.IO;
using UniversalDashboard.Services;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDElement")]
    public class NewElementCommand : CallbackCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewElementCommand));

        [Parameter(Mandatory = true, ParameterSetName = "HTML")]
		public string Tag { get; set; }
        [Parameter(ParameterSetName = "HTML")]
        public Hashtable Attributes { get; set; }
        [Parameter(ParameterSetName = "HTML")]
		public ScriptBlock Content { get; set; }
		[Parameter(ParameterSetName = "HTML")]
		public string OnMount { get; set; }
		[Parameter(Mandatory = true, ParameterSetName = "JS")]
		public string JavaScriptPath { get; set; }
		[Parameter(ParameterSetName = "JS")]
		public string ComponentName { get; set; } = "default";
		[Parameter(ParameterSetName = "JS")]
		public string ModuleName { get; set; }

		[Parameter(ParameterSetName = "JS")]
		public Hashtable Properties { get; set; }

        protected override void EndProcessing()
		{
			if (ParameterSetName == "HTML") {
				Log.Debug("HTML");

				var events = new List<ElementEventHandler>();

				if (Attributes != null) {
					var keysToRemove = new List<object>();
					foreach(DictionaryEntry attribute in Attributes) {
						var eventHandler = attribute.Value as ElementEventHandler;
						if (eventHandler == null) {

                            Endpoint callback = null;

							var scriptBlock = attribute.Value as ScriptBlock;
							if (scriptBlock != null)
                            {
                                callback = GenerateCallback(Id + attribute.Key.ToString(), scriptBlock, null);
                            }
                            else
                            {
                                var psobject = attribute.Value as PSObject;
                                callback = psobject?.BaseObject as Endpoint;

                            }

                            if (callback == null) continue;
                            
							eventHandler = new ElementEventHandler {
								Callback = callback,
								Event = attribute.Key.ToString(),
							};
						}

						events.Add(eventHandler);
						keysToRemove.Add(attribute.Key);
					}

					foreach(var key in keysToRemove)
						Attributes.Remove(key);
				}

				var element = new Element
				{
					Id = Id,
					Tag = Tag, 
					Attributes = Attributes,
					Events = events.ToArray(),
					Content = Content?.Invoke().Where(m => m != null).Select(m => m.BaseObject).ToArray(),
					Callback = GenerateCallback(Id),
                    AutoRefresh = AutoRefresh,
                    RefreshInterval = RefreshInterval,
					OnMount = OnMount
				};

				Log.Debug(JsonConvert.SerializeObject(element));

				WriteObject(element);
			} else {
				Log.Debug("JS");

				var path = GetUnresolvedProviderPathFromPSPath(JavaScriptPath);

				if (Properties != null) {
					if (!Properties.ContainsKey("id")) {
						Properties.Add("id", Id);
					}
				}

                AssetService.Instance.RegisterScript(path);

				var element = new Element
				{
					Id = Id,
					JavaScriptPath = path,
					Callback = GenerateCallback(Id),
					Properties = ToDictionary(Properties),
					ComponentName = ComponentName,
					ModuleName = ModuleName
				};

				Log.Debug(JsonConvert.SerializeObject(element));

				WriteObject(element);
			}

			
		}

        private object ToDictionary(object obj)
        {
            if (obj is Hashtable hashtable)
            {
                var dictionary = new Dictionary<string, object>();
                foreach (var key in hashtable.Keys)
                {
                    var value = hashtable[key];

                    dictionary.Add(key.ToString(), ToDictionary(value));
                }

                return dictionary;
            }
            else if (obj is PSObject psObject)
            {
                if (psObject.BaseObject != null)
                {
                    return psObject.BaseObject;
                }

                var dictionary = new Dictionary<string, object>();
                foreach (var prop in psObject.Properties)
                {
                    dictionary.Add(prop.Name, ToDictionary(prop.Value));
                }

                return dictionary;
            }
            else if (obj is IEnumerable enumerable && !(obj is string))
            {
                var items = new List<object>();
                foreach (var item in enumerable)
                {
                    items.Add(ToDictionary(item));
                }
                return items.ToArray();
            }

            return obj;
        }
    }
}
