using Newtonsoft.Json;
using System;
using UniversalDashboard.Models;

namespace UniversalDashboard.Utilities
{
    public class GenericComponentJsonConvert : JsonConverter
    {
        public override bool CanConvert(Type objectType)
        {
            return typeof(GenericComponent).IsAssignableFrom(objectType);
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            return null;
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            var component = value as GenericComponent;
            writer.WriteStartObject();
            
            foreach(var property in component.Properties)
            {
                writer.WritePropertyName(property.Key);
                serializer.Serialize(writer, property.Value);
            }

            writer.WriteEndObject();
        }
    }
}
