using System;
using System.Management.Automation.Runspaces;

namespace UniversalDashboard.Interfaces
{
    public interface IUDRunspaceFactory : IDisposable
    {
        IRunspaceReference GetRunspace();
        void ReturnRunspace(Runspace runspace);
    }
}
