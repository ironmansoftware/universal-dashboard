using System;
using System.Reflection;
using Microsoft.AspNetCore.Hosting;
using UniversalDashboard.Services;
using System.Collections.Generic;
using System.Net;
using System.Linq;
using System.IO;
using UniversalDashboard.Models;
using System.Management.Automation.Host;
using System.Security.Cryptography.X509Certificates;
using System.Security;
using System.Runtime.InteropServices;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.DotNet.PlatformAbstractions;
using System.Runtime.Loader;
using UniversalDashboard.Execution;
using UniversalDashboard.Utilities;
using UniversalDashboard.Interfaces;
using System.Management.Automation.Runspaces;

namespace UniversalDashboard
{
	public class Server
	{
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
			AppDomain.CurrentDomain.AssemblyResolve += AssemblyResolver.OnAssemblyResolve;

			IsRestApi = dashboardOptions.Dashboard == null;
			Port = dashboardOptions.Port;

			var assemblyBasePath = Path.GetDirectoryName(this.GetType().GetTypeInfo().Assembly.Location);
			var libraryDirectory = Path.Combine(assemblyBasePath, "..", "client");

			var calc = new CustomAssemblyLoadContext();
			calc.LoadNativeLibraries();

			var builder = new WebHostBuilder()
				.ConfigureServices((y) =>
				{
					DashboardService = new DashboardService(dashboardOptions, _reloadKey);
					y.Add(new ServiceDescriptor(typeof(IDashboardService), DashboardService));
                    
					if (_reloader != null)
						y.Add(new ServiceDescriptor(typeof(AutoReloader), _reloader));
				});
				builder = builder.UseKestrel(options =>
				{
					options.Listen(dashboardOptions.ListenAddress, dashboardOptions.Port, listenOptions =>
					{
						if (dashboardOptions.Certificate != null)
						{
							listenOptions.UseHttps(dashboardOptions.Certificate);
						}

						if (dashboardOptions.CertificateFile != null)
						{
							listenOptions.UseHttps(dashboardOptions.CertificateFile, SecureStringToString(dashboardOptions.Password));
						}
						
					});
					options.Limits.MaxRequestBodySize = null;
				});

			builder = builder
                .UseSetting("detailedErrors", "true")
                .UseLibuv()
                .UseStartup<ServerStartup>()
				.CaptureStartupErrors(true);

			if (Directory.Exists(libraryDirectory)) {
				builder.UseContentRoot(libraryDirectory);
			}

			host = builder.Build();

			if (dashboardOptions.Wait)
			{
				this.host.Run();
			}
			else
			{
				this.host.Start();
			}
			
			this.Running = true;

			Servers.Add(this);
		}

		public void Stop()
		{
			if (this.Running && this.host != null)
			{
				this.Running = false;
				this.host.Dispose();

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