﻿using System;
using System.Reflection;
using Microsoft.AspNetCore.Hosting;
using UniversalDashboard.Services;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Management.Automation.Host;
using System.Security;
using System.Runtime.InteropServices;
using Microsoft.Extensions.DependencyInjection;
using UniversalDashboard.Utilities;
using UniversalDashboard.Interfaces;
using Microsoft.AspNetCore.Server.Kestrel.Core;
using Microsoft.ApplicationInsights;
using UniversalDashboard.Cmdlets;

namespace UniversalDashboard
{
    public class Server
	{
		static Server()
		{
			AppDomain.CurrentDomain.AssemblyResolve += AssemblyResolver.OnAssemblyResolve;
		}
		
		public Server(string name, string fileName, bool autoReload, PSHost host, int port, bool https)
		{
			if (string.IsNullOrEmpty(name))
			{
				Name = $"Dashboard{_lastId}";
				_lastId++;
			}
			else
			{
				Name = name;
			}

			FileName = fileName;
            Port = port;

			_reloadKey = Guid.NewGuid().ToString();

			if (_reloader == null) {
				_reloader = new AutoReloader(host);
			}

			if (autoReload) {
				_reloader.StartWatchingFile(fileName, Port, _reloadKey, https);
			}

			if (Servers.Any(m => m.Name.Equals(Name, StringComparison.OrdinalIgnoreCase)))
			{
				throw new Exception($"Server with name {Name} already exists.");
			}
		}

		public static List<Server> Servers { get; set; } = new List<Server>();
		private static int _lastId;
		private static AutoReloader _reloader;

		public string Name { get; set; }

		internal string FileName {get;set;}
		
		private IWebHost host;

		public int Port { get; private set; }

		public bool Running { get; private set; }

        public IDashboardService DashboardService { get; private set; }

		internal bool IsRestApi { get; private set; }
		
		private string _reloadKey;

		public void Start(DashboardOptions dashboardOptions)
		{
			IsRestApi = dashboardOptions.Dashboard == null;
			Port = dashboardOptions.Port;

			if (!dashboardOptions.DisableTelemetry)
			{
				TelemetryClient client = new TelemetryClient();
				client.InstrumentationKey = "20963fa8-39e9-404f-98f4-b74627b140f4";
				client.TrackEvent("Start", new Dictionary<string, string> {
					{ "Edition", Constants.Edition },
					{ "Type", IsRestApi ? "REST" : "Dashboard"}
				});
			}
			
			Port = dashboardOptions.Port;

			var assemblyBasePath = Path.GetDirectoryName(this.GetType().GetTypeInfo().Assembly.Location);
			var libraryDirectory = Path.Combine(assemblyBasePath, "..", "client");

			var calc = new CustomAssemblyLoadContext();
			calc.LoadNativeLibraries();

			var builder = new WebHostBuilder()
				.ConfigureServices((y) =>
				{
					DashboardService = new DashboardService(dashboardOptions, _reloadKey);

                    foreach(var endpoint in CmdletExtensions.HostState.EndpointService.Endpoints)
                    {
                        DashboardService.EndpointService.Register(endpoint.Value);
                    }

                    foreach (var endpoint in CmdletExtensions.HostState.EndpointService.RestEndpoints)
                    {
                        DashboardService.EndpointService.Register(endpoint);
                    }


                    CmdletExtensions.HostState.EndpointService.Endpoints.Clear();
                    CmdletExtensions.HostState.EndpointService.RestEndpoints.Clear();

                    y.Add(new ServiceDescriptor(typeof(IDashboardService), DashboardService));
                    
					if (_reloader != null)
						y.Add(new ServiceDescriptor(typeof(AutoReloader), _reloader));
				});
				builder = builder.UseKestrel(options =>
				{
					// If we have a certificate configured
					if (dashboardOptions.Certificate != null || dashboardOptions.CertificateFile != null)
					{
						Action<ListenOptions> listenOptionsAction = (ListenOptions listenOptions) => {
								if (dashboardOptions.Certificate != null)
								{
									listenOptions.UseHttps(dashboardOptions.Certificate);
								}

								if (dashboardOptions.CertificateFile != null)
								{
									listenOptions.UseHttps(dashboardOptions.CertificateFile, SecureStringToString(dashboardOptions.Password));
								}
						};
						
						// If the ports are different, listen on HTTP and HTTPS
						if (dashboardOptions.Port != dashboardOptions.HttpsPort)
						{
							options.Listen(dashboardOptions.ListenAddress, dashboardOptions.Port);
							options.Listen(dashboardOptions.ListenAddress, dashboardOptions.HttpsPort, listenOptionsAction);
						}
						// If the ports are the same, just listen on the port and configure HTTPS
						else
						{
							options.Listen(dashboardOptions.ListenAddress, dashboardOptions.Port, listenOptionsAction);
						}
					}
					// If no certificate is configured, just listen on the port
					else
					{
						options.Listen(dashboardOptions.ListenAddress, dashboardOptions.Port);
					}

					options.Limits.MaxRequestBodySize = null;
				});

			builder = builder
                .UseSetting("detailedErrors", "true")
                .UseSockets()
                .UseStartup<ServerStartup>()
				.CaptureStartupErrors(true);

			if (Directory.Exists(libraryDirectory)) {
				builder.UseContentRoot(libraryDirectory);
			}

			host = builder.Build();

			Servers.Add(this);
			this.Running = true;

			if (dashboardOptions.Wait)
			{
				this.host.Run();
			}
			else
			{
				this.host.Start();
			}
		}

		public void Stop()
		{
			if (this.Running && this.host != null)
			{
				this.Running = false;

				this.host.StopAsync(TimeSpan.FromSeconds(1)).Wait();

                DashboardService.Dispose();

                Servers.Remove(this);

                _reloader.StopWatchingFile(FileName);
			}
		}

		String SecureStringToString(SecureString value)
		{
			IntPtr valuePtr = IntPtr.Zero;
			try
			{
				valuePtr = Marshal.SecureStringToGlobalAllocUnicode(value);
				return Marshal.PtrToStringUni(valuePtr);
			}
			finally
			{
				Marshal.ZeroFreeGlobalAllocUnicode(valuePtr);
			}
		}
	}


}