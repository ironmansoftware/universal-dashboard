using System;
using System.Collections;
using System.Collections.ObjectModel;
using System.Management.Automation;
using System.Management.Automation.Provider;
using System.IO;
using System.Collections.Generic;

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
        public static readonly Dictionary<string, object> Cache;

        #region Constructor

        static GlobalCachedVariableProvider()
        {
            Cache = new Dictionary<string, object>();
        }

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

            if (Cache.ContainsKey(name.ToLower()))
            {
                var item = Cache[name.ToLower()];
                base.WriteItemObject(item, name, false);
            }
        }

        protected override void NewItem(string path, string itemTypeName, object newItemValue)
        {
            if (Cache.ContainsKey(path.ToLower()))
            {
                Cache[path.ToLower()] = newItemValue;
            }
            else 
            {
                Cache.Add(path.ToLower(), newItemValue);
            }
        }

        protected override void SetItem(string name, object value) {
            if (Cache.ContainsKey(name.ToLower()))
            {
                Cache[name.ToLower()] = value;
            }
            else 
            {
                Cache.Add(name.ToLower(), value);
            }
        }

        protected override bool ItemExists(string path)
        {
            return Cache.ContainsKey(path.ToLower());
        }

        protected override bool IsValidPath(string path) {
            return !String.IsNullOrEmpty(path);
        }

        public void ClearContent(string path)
        {
            Cache.Remove(path.ToLower());
        }

        public object ClearContentDynamicParameters(string path)
        {
            throw new NotImplementedException();
        }

        public IContentReader GetContentReader(string path)
        {
            return new MemoryCacheContentReaderWriter(path.ToLower(), Cache);
        }

        public object GetContentReaderDynamicParameters(string path)
        {
            throw new NotImplementedException();
        }

        public IContentWriter GetContentWriter(string path)
        {
            return new MemoryCacheContentReaderWriter(path.ToLower(), Cache);
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
        private readonly Dictionary<string, object> _memoryCache;

        public MemoryCacheContentReaderWriter(string key, Dictionary<string, object> memoryCache)
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
            if (_memoryCache.TryGetValue(_key.ToLower(), out object value))
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
            object value;
            if (content.Count == 1)
            {
                value = content[0];
            }
            else
            {
                value = content;
            }

            if (_memoryCache.ContainsKey(_key.ToLower()))
            {
                _memoryCache[_key.ToLower()] = value;
            }
            else 
            {
                _memoryCache.Add(_key.ToLower(), value);
            }
            
            return content;
        }
    }
}
