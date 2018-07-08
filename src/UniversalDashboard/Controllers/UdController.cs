using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;

namespace UniversalDashboard.Controllers
{
    public abstract class UdController: Controller
    {
        public IMemoryCache MemoryCache { get; }

        public UdController(IMemoryCache memoryCache)
        {
            MemoryCache = memoryCache;
        }
    }
}
