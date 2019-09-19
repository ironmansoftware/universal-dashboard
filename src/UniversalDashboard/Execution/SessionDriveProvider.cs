// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

using System;
using Dbg = System.Management.Automation;
using System.Collections;
using System.Collections.ObjectModel;
using System.Management.Automation;
using System.Management.Automation.Provider;
using Microsoft.PowerShell.Commands;
using Microsoft.Extensions.Caching.Memory;
using System.IO;
using NLog;

namespace UniversalDashboard.Execution
{
    /// <summary>
    /// This provider is the data accessor for shell variables. It uses
    /// the HashtableProvider as the base class to get a hashtable as
    /// a data store.
    /// </summary>
    [CmdletProvider("Session", ProviderCapabilities.ShouldProcess)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.SetItem)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.RenameItem)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.CopyItem)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.GetItem)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.NewItem)]
    public sealed class SessionDriveVariableProvider : ContainerCmdletProvider, IContentCmdletProvider
    {
        private readonly IMemoryCache _memoryCache;
        private static readonly Logger Logger = LogManager.GetLogger(nameof(SessionDriveVariableProvider));

        #region Constructor

        /// <summary>
        /// The constructor for the provider that exposes variables to the user
        /// as drives.
        /// </summary>
        public SessionDriveVariableProvider()
        {
            _memoryCache = ExecutionService.MemoryCache;
        } // constructor

        #endregion Constructor

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

        private string ConnectionId 
        {
            get
            {
                return SessionState.PSVariable.Get("SessionId")?.Value as string;
            }
        }

        protected override void GetItem(string name)
        {
            var item = _memoryCache.Get(ConnectionId + name.ToLower());
            if (item != null)
            {
                base.WriteItemObject(item, name.ToLower(), false);
            }
        }

        protected override void NewItem(string path, string itemTypeName, object newItemValue)
        {
            _memoryCache.Set(ConnectionId + path.ToLower(), newItemValue);
        }

        protected override void SetItem(string name, object value)
        {
            _memoryCache.Set(ConnectionId + name.ToLower(), value);
        }

        protected override bool ItemExists(string path)
        {
            return _memoryCache.TryGetValue(ConnectionId + path.ToLower(), out object val);
        }

        protected override bool IsValidPath(string path)
        {
            return !String.IsNullOrEmpty(path);
        }

        public void ClearContent(string path)
        {
            _memoryCache.Remove(ConnectionId + path.ToLower());
        }

        public object ClearContentDynamicParameters(string path)
        {
            throw new NotImplementedException();
        }

        public IContentReader GetContentReader(string path)
        {
            Logger.Debug($"GetContentReader - {path} ");

            return new MemoryCacheContentReaderWriter(ConnectionId + path.ToLower(), _memoryCache);
        }

        public object GetContentReaderDynamicParameters(string path)
        {
            throw new NotImplementedException();
        }

        public IContentWriter GetContentWriter(string path)
        {
            Logger.Debug($"GetContentWriter - {path} ");

            return new MemoryCacheContentReaderWriter(ConnectionId + path.ToLower(), _memoryCache);
        }

        public object GetContentWriterDynamicParameters(string path)
        {
            throw new NotImplementedException();
        }
        #endregion DriveCmdletProvider overrides
    } // VariableProvider
}
