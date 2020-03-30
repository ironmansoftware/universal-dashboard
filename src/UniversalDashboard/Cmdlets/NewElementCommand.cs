using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;
using System.Management.Automation;
using UniversalDashboard.Models.Basics;
using System.Collections;
using System.Linq;
using System.Collections.Generic;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsCommon.New, "UDElement")]
    public class NewElementCommand : CallbackCmdlet
    {
		private readonly Logger Log = LogManager.GetLogger(nameof(NewElementCommand));

        [Parameter(Mandatory = true)]
		public string Tag { get; set; }
        [Parameter()]
        public Hashtable Attributes { get; set; }
        [Parameter()]
		public ScriptBlock Content { get; set; }
		[Parameter()]
		public string OnMount { get; set; }

        protected override void EndProcessing()
		{
			var events = new List<ElementEventHandler>();

			if (Attributes != null)
			{
				var keysToRemove = new List<object>();
				foreach (DictionaryEntry attribute in Attributes)
				{
					var eventHandler = attribute.Value as ElementEventHandler;
					if (eventHandler == null)
					{

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

						eventHandler = new ElementEventHandler
						{
							Callback = callback,
							Event = attribute.Key.ToString(),
						};
					}

					events.Add(eventHandler);
					keysToRemove.Add(attribute.Key);
				}

				foreach (var key in keysToRemove)
					Attributes.Remove(key);
			}

			var content = new object[0];
			if (Content != null && !string.IsNullOrEmpty(Content.ToString()))
			{
				var scriptBlock = ScriptBlock.Create(Content.ToString());
				content = scriptBlock?.Invoke().Where(m => m != null).Select(m => m.BaseObject).ToArray();
			}

			var element = new Element
			{
				Id = Id,
				Tag = Tag,
				Attributes = Attributes,
				Events = events.ToArray(),
				Content = content,
				Callback = GenerateCallback(Id),
				AutoRefresh = AutoRefresh,
				RefreshInterval = RefreshInterval,
				OnMount = OnMount
			};

			Log.Debug(JsonConvert.SerializeObject(element));

			WriteObject(element);
		}
    }
}
