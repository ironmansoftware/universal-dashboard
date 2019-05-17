using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Services
{
    public class AssetService
    {
        public Dictionary<string, string> Frameworks;

        public List<string> Assets;

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
            Assets = new List<string>();
            Frameworks = new Dictionary<string, string>();
        }

        public string RegisterAsset(string asset) {

            if (asset.StartsWith("http")) {
                Assets.Add(asset);
                return asset.Split('/').Last();
            }

            var fileInfo = new FileInfo(asset);
            Assets.Add(asset);
            return fileInfo.Name;
        }
        
        public string RegisterScript(string asset) {

            var fileInfo = new FileInfo(asset);
            Assets.Add(asset);
            return fileInfo.Name;
        }

        public string RegisterStylesheet(string asset) {
            var fileInfo = new FileInfo(asset);
            Assets.Add(asset);
            return fileInfo.Name;
        }

        public void RegisterFramework(string name, string rootAsset)
        {
            if (Frameworks.ContainsKey(name))
            {
                Frameworks.Remove(name);
            }

            Frameworks.Add(name, rootAsset);
        }

        public void ClearRegistration()
        {
            Assets.Clear();
            Frameworks.Clear();
        }

        public string FindAsset(string fileName)
        {
            try
            {
                return Assets.FirstOrDefault(m => {
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
