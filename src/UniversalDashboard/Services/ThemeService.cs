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
        private static Dictionary<string, List<string>> _cssMap = new Dictionary<string, List<string>>();

        public IEnumerable<Theme> LoadThemes()
        {
            var assemblyBasePath = Path.GetDirectoryName(this.GetType().GetTypeInfo().Assembly.Location);
            var themeDirectory = Path.Combine(assemblyBasePath, "Themes");

            foreach (var theme in Directory.EnumerateFiles(themeDirectory))
            {
                using (var powershell = PowerShell.Create())
                {
                    var hashtable = File.ReadAllText(theme);
                    powershell.AddScript(hashtable);

                    var themeHashable = powershell.Invoke().FirstOrDefault()?.BaseObject as Hashtable;

                    if (powershell.HadErrors)
                    {
                        foreach (var error in powershell.Streams.Error)
                        {
                            Logger.Warn("Failed to process theme: " + theme);
                            Logger.Warn(error.ErrorDetails.Message);
                        }
                        continue;
                    }

                    if (themeHashable == null)
                    {
                        Logger.Warn($"Invalid theme: {theme}");
                        continue;
                    }

                    if (!themeHashable.ContainsKey("Name"))
                    {
                        Logger.Warn("Invalid theme. Missing Name value.");
                        continue;
                    }

                    if (!themeHashable.ContainsKey("Definition"))
                    {
                        Logger.Warn("Invalid theme. Missing Definition value.");
                        continue;
                    }

                    var definition = themeHashable["Definition"] as Hashtable;
                    if (definition == null)
                    {
                        Logger.Warn("Invalid theme. Definition must be a Hashtable.");
                        continue;
                    }

                    var parent = string.Empty;
                    if (themeHashable.ContainsKey("Parent"))
                    {
                        parent = themeHashable["Parent"].ToString();
                    }

                    var atheme = new Theme
                    {
                        Name = themeHashable["Name"].ToString(),
                        Definition = definition,
                        Parent = parent,
                    };

                    Logger.Debug(JsonConvert.SerializeObject(atheme));
                    yield return atheme;
                }
            }
        }

        public string Create(Theme theme)
        {
            Logger.Debug("Rendering theme to CSS.");

            var hashtable = theme.Definition;
            var parentTheme = LoadThemes().FirstOrDefault(m => m.Name.Equals(theme.Parent, StringComparison.OrdinalIgnoreCase))?.Definition;

            if (parentTheme != null)
            {
                Logger.Debug("Merging with parent them: " + theme.Parent);
                hashtable = MergeHashtables(hashtable, parentTheme);
            }

            if (parentTheme == null && !string.IsNullOrEmpty(theme.Parent))
            {
                Logger.Warn("Could not find parent theme: " + theme.Parent);
            }

            var stringBuilder = new StringBuilder();

            foreach (object section in hashtable.Keys)
            {
                var identifier = section as string;
                if (identifier == null) throw new InvalidCastException("Hashtable key is not a string.");

                var children = hashtable[identifier] as Hashtable;
                if (children == null) throw new InvalidCastException("Hashtable value is not a hashtable.");

                if (_cssMap.ContainsKey(identifier.ToLower()))
                {
                    var ids = _cssMap[identifier.ToLower()];
                    foreach (var id in ids)
                    {
                        stringBuilder.AppendLine(id + " {");
                        TranslateHashtable(children, stringBuilder);
                        stringBuilder.AppendLine("}");
                    }
                }
                else
                {
                    stringBuilder.AppendLine(identifier + " {");
                    TranslateHashtable(children, stringBuilder);
                    stringBuilder.AppendLine("}");
                }
            }

            var themeContent = stringBuilder.ToString();

            Logger.Debug("Rendered theme content: " + themeContent);

            return themeContent;
        }

        private Hashtable MergeHashtables(Hashtable child, Hashtable parent)
        {
            var mergedTable = new Hashtable();

            foreach (var key in parent.Keys)
            {
                if (child.ContainsKey(key))
                {
                    var value = child[key];

                    var stringValue = value as string;
                    if (stringValue != null)
                    {
                        mergedTable.Add(key, value);
                    }

                    var hashtableValue = value as Hashtable;
                    var parentHashtableValue = parent[key] as Hashtable;
                    if (hashtableValue != null && parentHashtableValue != null)
                    {
                        var mergedTableValue = MergeHashtables(hashtableValue, parentHashtableValue);
                        mergedTable.Add(key, mergedTableValue);
                    }
                }
                else
                {
                    mergedTable.Add(key, parent[key]);
                }
            }

            foreach (var key in child.Keys)
            {
                if (!parent.ContainsKey(key))
                {
                    mergedTable.Add(key, child[key]);
                }
            }

            return mergedTable;
        }

        private void TranslateHashtable(Hashtable hashtable, StringBuilder stringBuilder)
        {
            foreach (object section in hashtable.Keys)
            {
                var identifier = section as string;
                if (identifier == null) throw new InvalidCastException("Hashtable key is not a string.");

                var value = hashtable[identifier];

                if (_cssMap.ContainsKey(identifier.ToLower()))
                {
                    identifier = _cssMap[identifier.ToLower()].First();
                }

                var setting = value as string;
                if (setting != null)
                {
                    stringBuilder.AppendLine("\t" + identifier + " : " + setting + ";");
                    continue;
                }

                var children = value as Hashtable;
                if (children != null)
                {
                    stringBuilder.AppendLine(identifier + " {");
                    TranslateHashtable(children, stringBuilder);
                    stringBuilder.AppendLine("}");
                    continue;
                }

                throw new InvalidCastException("Value of hashtable is not a hashtable or string");
            }
        }

        private static List<string> ToClasses(params string[] values)
        {
            return values.ToList();
        }
        static ThemeService()
        {
            // Classes
            _cssMap.Add("udcard", ToClasses(".ud-card"));
            _cssMap.Add("udchart", ToClasses(".ud-chart"));
            _cssMap.Add("udcollapsible", ToClasses(".ud-collapsible"));
            _cssMap.Add("udcollapsibleitem", ToClasses(".ud-collapsible-item"));
            _cssMap.Add("udcolumn", ToClasses(".ud-column"));
            _cssMap.Add("udcounter", ToClasses(".ud-counter"));
            _cssMap.Add("uddashboard", ToClasses(".ud-dashboard"));
            _cssMap.Add("udfooter", ToClasses(".ud-footer"));
            _cssMap.Add("udgrid", ToClasses(".ud-grid"));
            _cssMap.Add("udimage", ToClasses(".ud-image"));
            _cssMap.Add("udinput", ToClasses(".ud-input", ".datepicker-table td.is-today", ".datepicker-table td.is-selected", ".datepicker-date-display", ".datepicker-modal", ".datepicker-controls", ".datepicker-done", ".datepicker-cancel"));
            _cssMap.Add("udlink", ToClasses(".ud-link"));
            _cssMap.Add("udmonitor", ToClasses(".ud-monitor"));
            _cssMap.Add("udnavbar", ToClasses(".ud-navbar"));
            _cssMap.Add("udpagenavigation", ToClasses(".ud-page-navigation"));
            _cssMap.Add("udrow", ToClasses(".ud-row"));
            _cssMap.Add("udtable", ToClasses(".ud-table"));
            _cssMap.Add("udtabs", ToClasses("nav.mdc-tab-bar", ".mdc-tab-bar"));
            _cssMap.Add("udtab", ToClasses(".mdc-tab .mdc-tab__text-label"));
            _cssMap.Add("udtabactive", ToClasses("button.mdc-tab--active.mdc-ripple-upgraded.mdc-ripple-upgraded--background-focused.mdc-tab--active.mdc-tab", "button.mdc-tab--active.mdc-ripple-upgraded.mdc-tab--active.mdc-tab > div.mdc-tab__content > span", "button.mdc-tab--active.mdc-ripple-upgraded.mdc-tab--active.mdc-tab"));
            _cssMap.Add("udtabindicator", ToClasses(".mdc-tab-indicator--active .mdc-tab-indicator__content"));
            _cssMap.Add("udtabicon", ToClasses(".mdc-tab .mdc-tab__icon"));
            _cssMap.Add("udtabactiveicon", ToClasses("button.mdc-tab--active.mdc-ripple-upgraded.mdc-tab--active.mdc-tab > div.mdc-tab__content > i", ".mdc-tab .mdc-tab__icon"));
            _cssMap.Add("udimagecarouselindicator", ToClasses(".slider .indicators .indicator-item", ".slider .indicators .indicator-item.active"));
            _cssMap.Add("udimagecarouselindicatoractive", ToClasses(".slider .indicators .indicator-item.active"));

            // Properties
            _cssMap.Add("backgroundcolor", ToClasses("background-color"));
            _cssMap.Add("fontcolor", ToClasses("color"));
            _cssMap.Add("activefontcolor", ToClasses("color"));
            _cssMap.Add("activebackgroundcolor", ToClasses("background-color"));
            _cssMap.Add("indicatorcolor", ToClasses("border-color"));
            _cssMap.Add("indicatorheight", ToClasses("border-top-width"));
            _cssMap.Add("boxshadow", ToClasses("box-shadow"));
            _cssMap.Add("height", ToClasses("height"));
            _cssMap.Add("lineheight", ToClasses("line-height"));
            _cssMap.Add("width", ToClasses("width"));

        }
    }
}
