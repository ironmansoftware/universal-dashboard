using Microsoft.Extensions.Caching.Memory;
using UniversalDashboard.Models.Basics;
using System;
using System.Threading;

namespace UniversalDashboard.Services
{
    public class StateRequestService
    {
        private static MemoryCache memoryCache = new MemoryCache(new MemoryCacheOptions());

        public AutoResetEvent EventAvailable = new AutoResetEvent(false);

        public void Set(string requestId, Element state)
        {
            memoryCache.Set(requestId, state, TimeSpan.FromSeconds(5));
            EventAvailable.Set();
        }

        public bool TryGet(string requestId, out Element element)
        {
            if (memoryCache.TryGetValue(requestId, out element))
            {
                memoryCache.Remove(requestId);
                return true;
            }

            return false;
        }
    }
}
