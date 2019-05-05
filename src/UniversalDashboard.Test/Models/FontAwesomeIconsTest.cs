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
            Assert.Equal("address-card", FontAwesomeIcons.address_card_o.GetIconName());
            Assert.Equal("hand-point-right", FontAwesomeIcons.hand_o_right.GetIconName());
            Assert.Equal("empire", FontAwesomeIcons.ge.GetIconName());
        }
    }
}
