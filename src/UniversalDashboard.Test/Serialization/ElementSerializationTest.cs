using Newtonsoft.Json;
using UniversalDashboard.Models.Basics;
using Xunit;

namespace UniversalDashboard.Test.Serialization
{

    public class ElementSerializationTest
    {
        [Fact]
        public void ShouldDeserializeAttributes()
        {
            var json = "{\"tag\":\"input\",\"attributes\":{\"placeholder\":\"Type a chat message\",\"type\":\"textbox\",\"value\":\"ddd\"},\"events\":[],\"loading\":false}";

            var element = JsonConvert.DeserializeObject<Element>(json);

            Assert.NotNull(element.Attributes);
            Assert.Equal("ddd", element.Attributes["value"]);
        }
    }
}
