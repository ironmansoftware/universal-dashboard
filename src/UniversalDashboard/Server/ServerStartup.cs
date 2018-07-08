using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Logging;
using UniversalDashboard.Services;
using System;
using System.Linq;
using UniversalDashboard.Execution;
using NLog;
using NLog.Extensions.Logging;
using Microsoft.Extensions.Hosting;
using UniversalDashboard.Utilities;
using UniversalDashboard.Interfaces;
using Microsoft.AspNetCore.Mvc.Filters;

namespace UniversalDashboard
{
    internal class ServerStartup
	{
		private static readonly Logger Logger = LogManager.GetLogger(nameof(ServerStartup));

		public IConfigurationRoot Configuration { get; }
		private AutoReloader _reloader;

        public ServerStartup(IHostingEnvironment env)
		{
			var builder =
				new ConfigurationBuilder()
					.AddEnvironmentVariables();

			Configuration = builder.Build();
		}

		public void ConfigureServices(IServiceCollection services)
		{
			var autoReloaderService = services.FirstOrDefault(m => m.ServiceType == typeof(AutoReloader));
			_reloader = autoReloaderService?.ImplementationInstance as AutoReloader;

			var dashboardService = services.FirstOrDefault(m => m.ServiceType == typeof(IDashboardService));
			var dashboard = dashboardService?.ImplementationInstance as IDashboardService;

            services.AddResponseCompression();
			services.AddSignalR();
            services.AddTransient<StateRequestService>();
            services.AddSingleton<IHostedService, ScheduledEndpointManager>();
            services.AddTransient<IExecutionService, ExecutionService>();
			services.AddCors();
			services.AddDirectoryBrowser();
			services.AddSingleton(ExecutionService.MemoryCache);
            services.AddMvc().AddControllersAsServices();
			services.AddScoped<IFilterProvider, EncFilterProvider>();

            services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(25);
                options.Cookie.HttpOnly = true;
                options.Cookie.SecurePolicy = CookieSecurePolicy.SameAsRequest;
            });

            foreach(var plugin in PluginRegistry.Instance.Plugins.Where(m => m.WebServerConfiguration != null))
            {
                plugin.WebServerConfiguration.ConfigureServices(dashboard, services);
            }
        }

        public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory, IApplicationLifetime lifetime)
		{
			loggerFactory.AddNLog();
			app.UseResponseCompression();
			app.UseStatusCodePagesWithReExecute("/redirect/{0}");
			app.UseFileServer(new FileServerOptions()
			{
				FileProvider = new PhysicalFileProvider(env.ContentRootPath),
				RequestPath = new PathString(""),
				EnableDirectoryBrowsing = true
			});

			app.UseCors(builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader().AllowCredentials());

			app.UseSignalR(routes =>
            {
                routes.MapHub<DashboardHub>("dashboardhub");
            });
			app.UseWebSockets();

			app.UseSession();

            foreach (var plugin in PluginRegistry.Instance.Plugins.Where(m => m.WebServerConfiguration != null))
            {
                plugin.WebServerConfiguration.Configure(app, env, loggerFactory, lifetime);
            }

            app.UseMvc();
		}
	}
}