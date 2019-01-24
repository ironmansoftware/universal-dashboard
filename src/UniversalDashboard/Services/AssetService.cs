using System;
using System.Collections.Generic;
using UniversalDashboard.Utilities;

namespace UniversalDashboard.Services
{
    public class AssetService
    {
        private Dictionary<Guid, string> _scripts;
        private Dictionary<Guid, string> _styleSheets;

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
            _scripts = new Dictionary<Guid, string>();
            _styleSheets = new Dictionary<Guid, string>();
        }

        public void RegisterScript(string script)
        {
            var id = script.ToGuid();
            if (!_scripts.ContainsKey(id))
            {
                _scripts.Add(id, script);
            }
        }

        public string GetScript(Guid id)
        {
            if (_scripts.ContainsKey(id))
            {
                return _scripts[id];
            }
            return null;
        }

        public void RegisterStyleSheet(string stylesheet)
        {
            var id = stylesheet.ToGuid();
            if (!_styleSheets.ContainsKey(id))
            {
                _styleSheets.Add(id, stylesheet);
            }
        }

        public void ClearRegistration()
        {
            _scripts.Clear();
            _styleSheets.Clear();
        }
    }
}
