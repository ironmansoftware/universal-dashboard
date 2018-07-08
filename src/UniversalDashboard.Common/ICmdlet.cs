namespace UniversalDashboard.Interfaces
{
    public interface ICmdlet
    {
        void WriteWarning(string warning);
        void WriteError(string error);
    }
}
