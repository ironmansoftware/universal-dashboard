using Microsoft.AspNetCore.SignalR;
using NLog;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Management.Automation;
using System.Management.Automation.Host;
using System.Management.Automation.Runspaces;
using System.Security;
using UniversalDashboard.Execution;
using UniversalDashboard.Models.Enums;

namespace UniversalDashboard.Services
{
    public class UDHost : PSHost
    {
        private readonly UDHostUserInterface _udHostUserInterface;

        public UDHost()
        {
            _udHostUserInterface = new UDHostUserInterface();
        }

        public override string Name => "UDHost";

        public override Version Version => new Version(1, 0);

        public override Guid InstanceId => Guid.NewGuid();

        public override PSHostUserInterface UI => _udHostUserInterface;

        public override CultureInfo CurrentCulture => CultureInfo.CurrentCulture;

        public override CultureInfo CurrentUICulture => CultureInfo.CurrentUICulture;

        public override void EnterNestedPrompt()
        {
           
        }

        public override void ExitNestedPrompt()
        {

        }

        public override void NotifyBeginApplication()
        {

        }

        public override void NotifyEndApplication()
        {

        }

        public override void SetShouldExit(int exitCode)
        {

        }

        public override PSObject PrivateData
        {
            get
            {
                return _hostStateProxy ?? (_hostStateProxy = PSObject.AsPSObject(new HostState()));
            }
        }
        private PSObject _hostStateProxy;
    }

    public class UDHostUserInterface : PSHostUserInterface
    {
        private static readonly Logger Log = LogManager.GetLogger(nameof(UDHostUserInterface));

        public override PSHostRawUserInterface RawUI => null;

        public string ConnectionId { get; set; }

        public override Dictionary<string, PSObject> Prompt(string caption, string message, Collection<FieldDescription> descriptions)
        {
            throw new NotImplementedException();
        }

        public override int PromptForChoice(string caption, string message, Collection<ChoiceDescription> choices, int defaultChoice)
        {
            throw new NotImplementedException();
        }

        public override PSCredential PromptForCredential(string caption, string message, string userName, string targetName, PSCredentialTypes allowedCredentialTypes, PSCredentialUIOptions options)
        {
            throw new NotImplementedException();
        }

        public override PSCredential PromptForCredential(string caption, string message, string userName, string targetName)
        {
            throw new NotImplementedException();
        }

        public override string ReadLine()
        {
            throw new NotImplementedException();
        }

        public override SecureString ReadLineAsSecureString()
        {
            throw new NotImplementedException();
        }

        public override void Write(ConsoleColor foregroundColor, ConsoleColor backgroundColor, string value)
        {
            Log.Trace(value);
        }

        public override void Write(string value)
        {
            Log.Trace(value);
        }

        public override void WriteDebugLine(string message)
        {
            Log.Trace("[DEBUG]:" + message);
        }

        public override void WriteErrorLine(string value)
        {
            Log.Trace("[ERROR]:" + value);
        }

        public override void WriteLine(string value)
        {
            Log.Trace("[DEBUG]:" + value);
        }

        public override void WriteProgress(long sourceId, ProgressRecord record)
        {
            
        }

        public override void WriteVerboseLine(string message)
        {
            Log.Trace("[VERBOSE]:" + message);
        }

        public override void WriteWarningLine(string message)
        {
            Log.Trace("[WARNING]:" + message);
        }
    }
}
