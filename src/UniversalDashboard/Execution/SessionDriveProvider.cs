using System;
using System.Collections;
using System.Collections.ObjectModel;
using System.Management.Automation;
using System.Management.Automation.Provider;
using System.IO;
using NLog;

namespace UniversalDashboard.Execution
{
    /// <summary>
    /// This is the session scope driver provider.null 
    /// </summary>
    [CmdletProvider("Session", ProviderCapabilities.ShouldProcess)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.SetItem)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.RenameItem)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.CopyItem)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.GetItem)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.NewItem)]
    public sealed class SessionDriveVariableProvider : ContainerCmdletProvider, IContentCmdletProvider
    {
        private static readonly Logger Logger = LogManager.GetLogger(nameof(SessionDriveVariableProvider));

        #region DriveCmdletProvider overrides

        /// <summary>
        /// Initializes the variables drive
        /// </summary>
        ///
        /// <returns>
        /// An array of a single PSDriveInfo object representing the variables drive.
        /// </returns>
        ///
        protected override Collection<PSDriveInfo> InitializeDefaultDrives()
        {
            PSDriveInfo variableDrive =
                new PSDriveInfo(
                    "Session",
                    ProviderInfo,
                    String.Empty,
                    "Desc",
                    null);

            Collection<PSDriveInfo> drives = new Collection<PSDriveInfo>();
            drives.Add(variableDrive);
            return drives;
        } // InitializeDefaultDrives

        private string SessionId 
        {
            get
            {
                return SessionState.PSVariable.Get("SessionId")?.Value as string;
            }
        }

        protected override void GetItem(string name)
        {
            if (EndpointService.Instance.Sessions.ContainsKey(SessionId))
            {
                var value = EndpointService.Instance.Sessions[SessionId].GetVariableValue(name);
                if (value != null)
                {
                    base.WriteItemObject(value, name.ToLower(), false);
                }
            }
        }

        protected override void NewItem(string path, string itemTypeName, object newItemValue)
        {
            if (EndpointService.Instance.Sessions.ContainsKey(SessionId))
            {
                EndpointService.Instance.Sessions[SessionId].SetVariable(path, newItemValue);
            }
        }

        protected override void SetItem(string name, object value)
        {
            if (EndpointService.Instance.Sessions.ContainsKey(SessionId))
            {
                EndpointService.Instance.Sessions[SessionId].SetVariable(name, value);
            }
        }

        protected override bool ItemExists(string path)
        {
            if (EndpointService.Instance.Sessions.ContainsKey(SessionId))
            {
                return EndpointService.Instance.Sessions[SessionId].SessionVariables.ContainsKey(path.ToLower());
            }
            return false;
        }

        protected override bool IsValidPath(string path)
        {
            return !String.IsNullOrEmpty(path);
        }

        public void ClearContent(string path)
        {
            if (EndpointService.Instance.Sessions.ContainsKey(SessionId))
            {
                EndpointService.Instance.Sessions[SessionId].RemoveVariable(path);
            }
        }

        public object ClearContentDynamicParameters(string path)
        {
            throw new NotImplementedException();
        }

        public IContentReader GetContentReader(string path)
        {
            Logger.Debug($"GetContentReader - {path} ");

            if (EndpointService.Instance.Sessions.ContainsKey(SessionId))
            {
                return new SessionStateReaderWriter(path.ToLower(), EndpointService.Instance.Sessions[SessionId]);
            }

            return null;
        }

        public object GetContentReaderDynamicParameters(string path)
        {
            throw new NotImplementedException();
        }

        public IContentWriter GetContentWriter(string path)
        {
            Logger.Debug($"GetContentWriter - {path} ");

            if (EndpointService.Instance.Sessions.ContainsKey(SessionId))
            {
                return new SessionStateReaderWriter(path.ToLower(), EndpointService.Instance.Sessions[SessionId]);
            }

            return null;
        }

        public object GetContentWriterDynamicParameters(string path)
        {
            throw new NotImplementedException();
        }
        #endregion DriveCmdletProvider overrides
    }

    public class SessionStateReaderWriter : IContentWriter, IContentReader
    {
        private readonly string _name;
        private readonly Models.SessionState _sessionState;

        public SessionStateReaderWriter(string name, Models.SessionState sessionState)
        {
            _name = name; 
            _sessionState = sessionState;
        }

        public void Close()
        {
            
        }

        public void Dispose()
        {
        }

        public IList Read(long readCount)
        {
            var value = _sessionState.GetVariableValue(_name);
            if (value != null)
            {
                return new ArrayList
                {
                    value
                };
            }

            return null;
        }

        public void Seek(long offset, SeekOrigin origin)
        {
            
        }

        public IList Write(IList content)
        {
            if (content.Count == 1)
            {
                _sessionState.SetVariable(_name,  content[0]);
            }
            else
            {
                _sessionState.SetVariable(_name,  content);
            }
            
            return content;
        }
    }
}
