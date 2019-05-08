using Newtonsoft.Json;
using UniversalDashboard.Models;
using Xunit;

namespace UniversalDashboard.Test.Models
{

    public class FontAwesomeIconsTest
    {
        [Fact]
        public void ShouldConvertFromOldIconToNewIcon()
        {
            Assert.Equal("AddressCard", FontAwesomeIcons.address_card_o.GetIconName());
            Assert.Equal("HandPointRight", FontAwesomeIcons.hand_o_right.GetIconName());
            Assert.Equal("Empire", FontAwesomeIcons.ge.GetIconName());
        }
    }
}
