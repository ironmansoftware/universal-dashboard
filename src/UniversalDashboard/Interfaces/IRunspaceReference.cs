using System;
using System.Management.Automation.Runspaces;

namespace UniversalDashboard.Interfaces
{
    public interface IRunspaceReference : IDisposable
    {
        Runspace Runspace { get; }
    }
}
