using System;
using System.Collections.Generic;
using System.Collections.Concurrent;
using System.IO;
using System.Linq;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Services
{
    public class AssetService
    {
        public ConcurrentDictionary<string, string> Frameworks;
        public IEnumerable<string> Plugins => _plugins.Keys;
        public IEnumerable<string> Assets => _assets.Keys;

        private ConcurrentDictionary<string, string> _plugins;
        private ConcurrentDictionary<string, string> _assets;

        private static AssetService _instance;

        public static AssetService Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new AssetService();
                }
                return _instance;
            }
        }

        private AssetService()
        {
            _assets = new ConcurrentDictionary<string, string>();
            Frameworks = new ConcurrentDictionary<string, string>();
            _plugins = new ConcurrentDictionary<string, string>();
        }

        public string RegisterAsset(string asset) {

            if (asset.StartsWith("http")) {
                _assets.TryAdd(asset, string.Empty);
                return asset.Split('/').Last();
            }

            var fileInfo = new FileInfo(asset);
            _assets.TryAdd(asset, string.Empty);
            return fileInfo.Name;
        }
        
        public string RegisterScript(string asset) {

            var fileInfo = new FileInfo(asset);
            _assets.TryAdd(asset, string.Empty);
            return fileInfo.Name;
        }

        public string RegisterStylesheet(string asset) {
            var fileInfo = new FileInfo(asset);
            _assets.TryAdd(asset, string.Empty);
            return fileInfo.Name;
        }

        public void RegisterFramework(string name, string rootAsset)
        {
            if (Frameworks.ContainsKey(name))
            {
                Frameworks.TryRemove(name, out string value);
            }

            Frameworks.TryAdd(name, rootAsset);
        }

        public void RegisterPlugin(string rootAsset)
        {
            if (_plugins.ContainsKey(rootAsset))
            {
                _plugins.TryRemove(rootAsset, out string value);
            }

            _plugins.TryAdd(rootAsset, string.Empty);
        }

        public void ClearRegistration()
        {
            _assets.Clear();
            Frameworks.Clear();
        }

        public string FindAsset(string fileName)
        {
            try
            {
                return _assets.Keys.FirstOrDefault(m => {
                    if (m.StartsWith("http"))
                    {
                        return m.Split('/').Last().Equals(fileName);
                    }
                    return new FileInfo(m).Name.Equals(fileName, StringComparison.OrdinalIgnoreCase);
                });
            }
            catch
            {
                return null;
            }
        }
    }
}
