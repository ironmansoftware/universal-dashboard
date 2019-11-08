using System.Collections;
using System.Collections.Generic;
using System.Management.Automation;

namespace UniversalDashboard.Utilities
{
    public static class ObjectExtensions
    {
        public static object ToDictionary(this object obj)
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
                    return ToDictionary(psObject.BaseObject);
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
