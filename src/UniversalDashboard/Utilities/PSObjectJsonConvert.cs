using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Management.Automation;

namespace UniversalDashboard.Utilities
{
    public class PSObjectJsonConvert : JsonConverter
    {
        public override bool CanConvert(Type objectType)
        {
            return typeof(PSObject).IsAssignableFrom(objectType) || typeof(Hashtable).IsAssignableFrom(objectType);
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            return null;
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            var dictionary = value.ToDictionary() as Dictionary<string, object>;

            writer.WriteStartObject();
           
            foreach (var property in dictionary)
            {
                writer.WritePropertyName(property.Key);
                serializer.Serialize(writer, property.Value);
            }

            writer.WriteEndObject();
        }
    }
}
