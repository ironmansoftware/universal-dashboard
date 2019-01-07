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
using UniversalDashboard.Interfaces;
using Microsoft.AspNetCore.Mvc.Filters;
using System.IO;
using DotNetify;
using UniversalDashboard.Models;

namespace UniversalDashboard
{
    internal class ServerStartup
	{
		private static readonly Logger Logger = LogManager.GetLogger(nameof(ServerStartup));

		public IConfigurationRoot Configuration { get; }
		private AutoReloader _reloader;

        public ServerStartup(Microsoft.AspNetCore.Hosting.IHostingEnvironment env)
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

            var dashboardService = services.FirstOrDefault(m => m.ServiceType == typeof(IDashboardService)).ImplementationInstance as IDashboardService;

            services.AddResponseCompression();
			services.AddSignalR(hubOptions =>
            {
                hubOptions.EnableDetailedErrors = true;
            });
            services.AddTransient<StateRequestService>();
            services.AddSingleton<IHostedService, ScheduledEndpointManager>();
            services.AddTransient<IExecutionService, ExecutionService>();
			services.AddCors();
			services.AddDirectoryBrowser();
			services.AddSingleton(ExecutionService.MemoryCache);
			services.AddDotNetify();
            services.AddMvc();

            services.AddScoped<IFilterProvider, EncFilterProvider>();

            services.AddSession(options =>
            {
                options.IdleTimeout = dashboardService.Dashboard == null ? TimeSpan.FromMinutes(25) : dashboardService.Dashboard.IdleTimeout;
                options.Cookie.HttpOnly = true;
                options.Cookie.SecurePolicy = CookieSecurePolicy.SameAsRequest;
            });
        }

        public void Configure(IApplicationBuilder app, Microsoft.AspNetCore.Hosting.IHostingEnvironment env, ILoggerFactory loggerFactory, Microsoft.AspNetCore.Hosting.IApplicationLifetime lifetime)
		{
			var provider = new Microsoft.AspNetCore.StaticFiles.FileExtensionContentTypeProvider();
			// Add new mappings
			provider.Mappings[".ps1"] 	= "text/plain";
			provider.Mappings[".psm1"] 	= "text/plain";
			provider.Mappings[".psd1"] 	= "text/plain";
			provider.Mappings[".log"] 	= "text/plain";
			provider.Mappings[".yml"] 	= "text/plain";

			loggerFactory.AddNLog();
			app.UseResponseCompression();
            app.UseStatusCodePages(async context => {

                if (context.HttpContext.Response.StatusCode == 404 && !context.HttpContext.Request.Path.StartsWithSegments("/api"))
                {
                    var response = context.HttpContext.Response;
                    response.StatusCode = 200;
                    var filePath = env.ContentRootPath + "/index.html";
                    response.ContentType = "text/html; charset=utf-8";
                    var file = File.ReadAllText(filePath);
                    await response.WriteAsync(file);
                }
                else
                {
                    await context.Next(context.HttpContext);
                }
            });
			
			app.UseStaticFiles(new StaticFileOptions()
			{
				FileProvider = new PhysicalFileProvider(env.ContentRootPath),
				RequestPath = new PathString(""),
                ServeUnknownFileTypes = true,
				ContentTypeProvider = provider
			});

			var dashboardService = app.ApplicationServices.GetService(typeof(IDashboardService)) as IDashboardService;

			if (dashboardService?.DashboardOptions?.PublishedFolders != null) {
				foreach(var publishedFolder in dashboardService.DashboardOptions.PublishedFolders) {
					app.UseStaticFiles(new StaticFileOptions
                    {
						RequestPath = publishedFolder.RequestPath,
						FileProvider = new PhysicalFileProvider(publishedFolder.Path),
                        ServeUnknownFileTypes = true,
						ContentTypeProvider = provider
                    });
				}
			}

			app.UseCors(builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader().AllowCredentials());

			app.UseSignalR(routes =>
            {
                routes.MapHub<DashboardHub>("/dashboardhub");
				routes.MapDotNetifyHub();
            });
			app.UseDotNetify(config =>
            {
                foreach(var viewModel in dashboardService.Dashboard?.ViewModels)
                {
                    config.Register(viewModel.Name, _ =>
                    {
                        var executionService = app.ApplicationServices.GetService(typeof(IExecutionService)) as IExecutionService;
                        return new ViewModel(executionService, viewModel.Members);
                    });
                }
            });
			app.UseWebSockets();

			app.UseSession();

            app.UseMvc();
		}
	}
}