using System;
using System.Management.Automation.Runspaces;

namespace UniversalDashboard.Interfaces
{
    public interface IUDRunspaceFactory : IDisposable
    {
        IRunspaceReference GetRunspace();
        IRunspaceReference GetDebugRunspace();
        void ReturnRunspace(Runspace runspace);
        void ReturnDebugRunspace();
    }
}
