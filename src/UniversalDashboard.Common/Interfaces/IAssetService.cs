using System.Collections.Generic;

namespace UniversalDashboard.Interfaces
{
    public interface IAssetService
    {
        IEnumerable<string> Assets { get; }
        IEnumerable<string> Plugins { get; }
        string FindAsset(string fileName);
    }
}