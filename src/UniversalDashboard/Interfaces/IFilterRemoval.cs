using Microsoft.AspNetCore.Mvc.Filters;

namespace UniversalDashboard
{
    public interface IFilterRemoval 
    {
        bool ShouldRemove(FilterProviderContext context);
    }
}