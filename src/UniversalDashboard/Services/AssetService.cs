using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Services
{
    public class AssetService
    {
        public Dictionary<Guid, string> Scripts;
        public Dictionary<Guid, string> Stylesheets;

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
            Scripts = new Dictionary<Guid, string>();
            Stylesheets = new Dictionary<Guid, string>();
        }

        public Guid RegisterScript(string script)
        {
            var id = script.ToGuid();
            if (!Scripts.ContainsKey(id))
            {
                Scripts.Add(id, script);
            }

            return id;
        }

        public string GetScript(Guid id)
        {
            if (Scripts.ContainsKey(id))
            {
                return Scripts[id];
            }
            return null;
        }

        public void RegisterStyleSheet(string stylesheet)
        {
            var id = stylesheet.ToGuid();
            if (!Stylesheets.ContainsKey(id))
            {
                Stylesheets.Add(id, stylesheet);
            }
        }

        public void ClearRegistration()
        {
            Scripts.Clear();
            Stylesheets.Clear();
        }

        public string FindAsset(string fileName)
        {
            try
            {
                var file = Scripts.Values.FirstOrDefault(m => new FileInfo(m).Name.Equals(fileName, StringComparison.OrdinalIgnoreCase));
                if (file != null)
                {
                    return file;
                }

                file = Stylesheets.Values.FirstOrDefault(m => new FileInfo(m).Name.Equals(fileName, StringComparison.OrdinalIgnoreCase));

                return file;
            }
            catch
            {
                return null;
            }
        }
    }
}
