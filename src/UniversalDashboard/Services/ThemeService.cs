using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Management.Automation;
using System.Reflection;
using System.Text;
using Newtonsoft.Json;
using NLog;
using UniversalDashboard.Models;

namespace UniversalDashboard.Services
{
	public class ThemeService
	{
        private static Logger Logger = LogManager.GetLogger(nameof(ThemeService));
        private static Dictionary<string, string> _cssMap = new Dictionary<string, string>();

        public IEnumerable<Theme> LoadThemes() {
            var assemblyBasePath = Path.GetDirectoryName(this.GetType().GetTypeInfo().Assembly.Location);
			var themeDirectory = Path.Combine(assemblyBasePath, "Themes");

            foreach(var theme in Directory.EnumerateFiles(themeDirectory)) {
                using(var powershell = PowerShell.Create()) {
                    var hashtable = File.ReadAllText(theme);
                    powershell.AddScript(hashtable);

                    var themeHashable = powershell.Invoke().FirstOrDefault()?.BaseObject as Hashtable;

                    if (powershell.HadErrors) {
                        foreach(var error in powershell.Streams.Error) {
                            Logger.Warn("Failed to process theme: " + theme);
                            Logger.Warn(error.ErrorDetails.Message);
                        }
                        continue;
                    }

                    if (themeHashable == null) {
                        Logger.Warn($"Invalid theme: {theme}");
                        continue;
                    }

                    if (!themeHashable.ContainsKey("Name")) {
                        Logger.Warn("Invalid theme. Missing Name value.");
                        continue;
                    }

                    if (!themeHashable.ContainsKey("Definition")) {
                        Logger.Warn("Invalid theme. Missing Definition value.");
                        continue;
                    }

                    var definition = themeHashable["Definition"] as Hashtable;
                    if (definition == null) {
                        Logger.Warn("Invalid theme. Definition must be a Hashtable.");
                        continue;
                    }

                    var parent = string.Empty;
                    if (themeHashable.ContainsKey("Parent")) {
                        parent = themeHashable["Parent"].ToString();
                    }

                     var atheme = new Theme {
                        Name = themeHashable["Name"].ToString(),
                        Definition = definition,
                        Parent = parent,
                    };

                    Logger.Debug(JsonConvert.SerializeObject(atheme));
                    yield return atheme;
                }
            }
        }

		public string Create(Theme theme) {
            Logger.Debug("Rendering theme to CSS.");

            var hashtable = theme.Definition;
            var parentTheme = LoadThemes().FirstOrDefault(m => m.Name.Equals(theme.Parent, StringComparison.OrdinalIgnoreCase))?.Definition;

            if (parentTheme != null) {
                Logger.Debug("Merging with parent them: " + theme.Parent);
                hashtable = MergeHashtables(hashtable, parentTheme);
            }

            if (parentTheme == null && !string.IsNullOrEmpty(theme.Parent)) {
                Logger.Warn("Could not find parent theme: " + theme.Parent);
            }

            var stringBuilder = new StringBuilder();

            foreach(object section in hashtable.Keys) {
                var identifier = section as string;
                if (identifier == null) throw new InvalidCastException("Hashtable key is not a string.");

                var children = hashtable[identifier] as Hashtable;
                if (children == null) throw new InvalidCastException("Hashtable value is not a hashtable.");

                if (_cssMap.ContainsKey(identifier.ToLower())) {
                    identifier = _cssMap[identifier.ToLower()];
                } 

                stringBuilder.AppendLine(identifier + " {");
            
                TranslateHashtable(children, stringBuilder);

                stringBuilder.AppendLine("}");
            }   

            var themeContent = stringBuilder.ToString();

            Logger.Debug("Rendered theme content: " + themeContent);

            return themeContent;
        }

        private Hashtable MergeHashtables(Hashtable child, Hashtable parent) {
            var mergedTable = new Hashtable();

            foreach(var key in parent.Keys) {
                if (child.ContainsKey(key)) {
                    var value = child[key];

                    var stringValue = value as string;
                    if (stringValue != null) {
                        mergedTable.Add(key, value);
                    }

                    var hashtableValue = value as Hashtable;
                    var parentHashtableValue = parent[key] as Hashtable;
                    if (hashtableValue != null && parentHashtableValue != null) { 
                        var mergedTableValue = MergeHashtables(hashtableValue, parentHashtableValue);
                        mergedTable.Add(key, mergedTableValue);
                    }
                }
                else {
                    mergedTable.Add(key, parent[key]);
                }
            }

            foreach(var key in child.Keys) {
                if (!parent.ContainsKey(key)) {
                    mergedTable.Add(key, child[key]);
                }
            }

            return mergedTable;
        }

        private void TranslateHashtable(Hashtable hashtable, StringBuilder stringBuilder) {
            foreach(object section in hashtable.Keys) {
                var identifier = section as string;
                if (identifier == null) throw new InvalidCastException("Hashtable key is not a string.");

                var value = hashtable[identifier];

                if (_cssMap.ContainsKey(identifier.ToLower())) {
                    identifier = _cssMap[identifier.ToLower()];
                } 

                var setting = value as string;
                if (setting != null) {
                    stringBuilder.AppendLine("\t" + identifier + " : " + setting + ";");
                    continue;
                }

                var children = value as Hashtable;
                if (children != null) {
                    stringBuilder.AppendLine(identifier + " {");
                    TranslateHashtable(children, stringBuilder);
                    stringBuilder.AppendLine("}");
                    continue;
                }

                throw new InvalidCastException("Value of hashtable is not a hashtable or string");
            }
        }

        static ThemeService() {
            // Classes
            _cssMap.Add("udcard", ".ud-card");
            _cssMap.Add("udchart", ".ud-chart");
            _cssMap.Add("udcollapsible", ".ud-collapsible");
            _cssMap.Add("udcollapsibleitem", ".ud-collapsible-item");
            _cssMap.Add("udcolumn", ".ud-column");
            _cssMap.Add("udcounter", ".ud-counter");
            _cssMap.Add("uddashboard", ".ud-dashboard");
            _cssMap.Add("udfooter", ".ud-footer");
            _cssMap.Add("udgrid", ".ud-grid");
            _cssMap.Add("udimage", ".ud-image");
            _cssMap.Add("udinput", ".ud-input");
            _cssMap.Add("udlink", ".ud-link");
            _cssMap.Add("udmonitor", ".ud-monitor");
            _cssMap.Add("udnavbar", ".ud-navbar");
            _cssMap.Add("udpagenavigation", ".ud-page-navigation");
            _cssMap.Add("udrow", ".ud-row");
            _cssMap.Add("udtable", ".ud-table");

            // Properties
            _cssMap.Add("backgroundcolor", "background-color");
            _cssMap.Add("fontcolor", "color");

        }
	}
}
