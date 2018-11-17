using NLog;
using NLog.Config;
using NLog.Targets;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using System.Threading.Tasks;

namespace UniversalDashboard.Cmdlets
{
	[Cmdlet(VerbsLifecycle.Enable, "UDLogging")]
    public class EnableLoggingCommand : PSCmdlet
    {
        [Parameter()]
        [ValidateSet("Error", "Warning", "Info", "Debug")]
        public string Level { get; set; } = "Debug";

		[Parameter]
		public string FilePath { get; set; }

		[Parameter]
		public SwitchParameter Console { get; set; }

		protected override void EndProcessing()
		{
			var config = new LoggingConfiguration();

			LogLevel level = null;
			if (Level.Equals("Error", StringComparison.OrdinalIgnoreCase))
			{
				level = LogLevel.Error;
			}

			if (Level.Equals("Warning", StringComparison.OrdinalIgnoreCase))
			{
				level = LogLevel.Warn;
			}

			if (Level.Equals("Info", StringComparison.OrdinalIgnoreCase))
			{
				level = LogLevel.Info;
			}

			if (Level.Equals("Debug", StringComparison.OrdinalIgnoreCase))
			{
				level = LogLevel.Debug;
			}



			if (!string.IsNullOrEmpty(FilePath))
			{
				var resolvedPath = GetUnresolvedProviderPathFromPSPath(FilePath);

				var fileTarget = new FileTarget();
				fileTarget.FileName = resolvedPath;
				fileTarget.Layout = @"${date:format=HH\:mm\:ss} [${level}] ${logger} ${message}";
				config.AddTarget("file", fileTarget);

				var rule2 = new LoggingRule("*", level, fileTarget);
				config.LoggingRules.Add(rule2);
			}

			if (string.IsNullOrEmpty(FilePath) || Console)
			{
				var consoleTarget = new ColoredConsoleTarget();
				consoleTarget.Layout = @"${date:format=HH\:mm\:ss} [${level}] ${logger} ${message}";
				config.AddTarget("console", consoleTarget);

				var rule1 = new LoggingRule("*", level, consoleTarget);
				config.LoggingRules.Add(rule1);

			}

			LogManager.Configuration = config;
		}
	}
}
