using Microsoft.AspNetCore.Mvc.ApplicationParts;
using Microsoft.AspNetCore.Mvc.Controllers;
using System.Collections.Generic;
using UniversalDashboard.Interfaces;

namespace UniversalDashboard.Controllers
{
    public class DynamicControllerFeatureProvider : IApplicationFeatureProvider<ControllerFeature>
    {
        private readonly IDashboardService _dashboardService;

        public DynamicControllerFeatureProvider(IDashboardService dashboardService)
        {
            _dashboardService = dashboardService;
        }

        public void PopulateFeature(IEnumerable<ApplicationPart> parts, ControllerFeature feature)
        {
            var dynamicControllerEmitter = new DynamicControllerEmitter();
            var controllerTypeInfo = dynamicControllerEmitter.EmitController(_dashboardService);

            feature.Controllers.Add(
                    controllerTypeInfo
            );
        }
    }
}
