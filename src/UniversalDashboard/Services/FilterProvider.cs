using System.Linq;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc.Authorization;

namespace UniversalDashboard
{
    public class EncFilterProvider : IFilterProvider
    {
        public int Order
        {
            get
            {
                return -1500;
            }
        }

        public void OnProvidersExecuted(FilterProviderContext context)
        {
        }

        public void OnProvidersExecuting(FilterProviderContext context)
        {
            var filterRemoval = context.ActionContext.HttpContext.RequestServices.GetService(typeof(IFilterRemoval)) as IFilterRemoval;
            if (filterRemoval == null || filterRemoval.ShouldRemove(context)) 
            {
                // remove authorize filters
                var authFilters = context.Results.Where(x => 
                x.Descriptor.Filter.GetType() == typeof(AuthorizeFilter)).ToList();
                foreach(var f in authFilters)
                    context.Results.Remove(f);
            }
        }
    }
}


