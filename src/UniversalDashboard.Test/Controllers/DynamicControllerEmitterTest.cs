using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using NSubstitute;
using UniversalDashboard.Controllers;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;
using UniversalDashboard.Models.Basics;
using Xunit;

namespace UniversalDashboard.Test.Controllers
{

    public class DynamicControllerEmitterTest
    {
        [Fact]
        public void ShouldGenerateTypeWithPage()
        {
            var dashboard = new Dashboard();
            dashboard.Pages = new List<Page> {
                new Page {
                    Name = "home"
                }
            };

            var dashboardService = Substitute.For<IDashboardService>();
            dashboardService.Dashboard.Returns(dashboard);

            var emitter = new DynamicControllerEmitter();
            var controllerType = emitter.EmitController(dashboardService);

            var instance = Activator.CreateInstance(controllerType.UnderlyingSystemType, dashboardService);

            var page = controllerType.GetMethods().First().Invoke(instance, new object[0]) as Page;

            Assert.Equal("home", page.Name);
        }
    }
}
