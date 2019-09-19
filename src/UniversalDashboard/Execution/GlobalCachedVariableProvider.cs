using System;
using System.Collections;
using System.Collections.ObjectModel;
using System.Management.Automation;
using System.Management.Automation.Provider;
using Microsoft.Extensions.Caching.Memory;
using System.IO;

namespace UniversalDashboard.Execution
{
    [CmdletProvider("Cache", ProviderCapabilities.ShouldProcess)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.SetItem)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.RenameItem)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.CopyItem)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.GetItem)]
    [OutputType(typeof(PSVariable), ProviderCmdlet = ProviderCmdlet.NewItem)]
    public sealed class GlobalCachedVariableProvider : ContainerCmdletProvider, IContentCmdletProvider
    {
        private readonly IMemoryCache _memoryCache;

        #region Constructor

        /// <summary>
        /// The constructor for the provider that exposes variables to the user
        /// as drives.
        /// </summary>
        public GlobalCachedVariableProvider()
        {
            _memoryCache = ExecutionService.MemoryCache;
        } // constructor

        #endregion Constructor

        #region DriveCmdletProvider overrides

        protected override Collection<PSDriveInfo> InitializeDefaultDrives()
        {
            PSDriveInfo variableDrive =
                new PSDriveInfo(
                    "Cache",
                    ProviderInfo,
                    String.Empty,
                    "Memory cache provider for Universal Dashboard",
                    null);

            Collection<PSDriveInfo> drives = new Collection<PSDriveInfo>();
            drives.Add(variableDrive);
            return drives;
        } // InitializeDefaultDrives

        protected override void GetItem(string name) {
            var item = _memoryCache.Get(name);
            if (item != null) {
                base.WriteItemObject(item, name, false);
            }
        }

        protected override void NewItem(string path, string itemTypeName, object newItemValue)
        {
            _memoryCache.Set(path.ToLower(), newItemValue);
        }

        protected override void SetItem(string name, object value) {
            _memoryCache.Set(name.ToLower(), value);
        }

        protected override bool ItemExists(string path)
        {
            return _memoryCache.TryGetValue(path.ToLower(), out object val);
        }

        protected override bool IsValidPath(string path) {
            return !String.IsNullOrEmpty(path);
        }

        public void ClearContent(string path)
        {
            _memoryCache.Remove(path.ToLower());
        }

        public object ClearContentDynamicParameters(string path)
        {
            throw new NotImplementedException();
        }

        public IContentReader GetContentReader(string path)
        {
            return new MemoryCacheContentReaderWriter(path.ToLower(), _memoryCache);
        }

        public object GetContentReaderDynamicParameters(string path)
        {
            throw new NotImplementedException();
        }

        public IContentWriter GetContentWriter(string path)
        {
            return new MemoryCacheContentReaderWriter(path.ToLower(), _memoryCache);
        }

        public object GetContentWriterDynamicParameters(string path)
        {
            throw new NotImplementedException();
        }
        #endregion DriveCmdletProvider overrides
    } 

    internal class MemoryCacheContentReaderWriter : IContentWriter, IContentReader
    {
        private readonly string _key;
        private readonly IMemoryCache _memoryCache;

        public MemoryCacheContentReaderWriter(string key, IMemoryCache memoryCache)
        {
            _key = key;
            _memoryCache = memoryCache;
        }

        public void Close()
        {
            
        }

        public void Dispose()
        {
            
        }

        public IList Read(long readCount)
        {
            if (_memoryCache.TryGetValue(_key, out object value))
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
                _memoryCache.Set(_key, content[0]);
            }
            else
            {
                _memoryCache.Set(_key, content);
            }
            
            return content;
        }
    }
}
