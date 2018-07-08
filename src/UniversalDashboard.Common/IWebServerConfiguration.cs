using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace UniversalDashboard.Interfaces
{
    public interface IWebServerConfiguration
    {
        void ConfigureServices(IDashboardService dashboardService, IServiceCollection services);
        void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory, IApplicationLifetime lifetime);
    }
}
