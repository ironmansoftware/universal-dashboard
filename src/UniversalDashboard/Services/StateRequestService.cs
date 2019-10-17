using Microsoft.Extensions.Caching.Memory;
using UniversalDashboard.Models.Basics;
using System;
using System.Threading;

namespace UniversalDashboard.Services
{
    public class StateRequestService
    {
        private readonly IMemoryCache _memoryCache;

        public AutoResetEvent EventAvailable = new AutoResetEvent(false);

        public StateRequestService(IMemoryCache memoryCache)
        {
            _memoryCache = memoryCache;
        }

        public void Set(string requestId, Element state)
        {
            _memoryCache.Set(requestId, state, TimeSpan.FromSeconds(5));
            EventAvailable.Set();
        }

        public bool TryGet(string requestId, out Element element)
        {
            if (_memoryCache.TryGetValue(requestId, out element))
            {
                _memoryCache.Remove(requestId);
                return true;
            }

            return false;
        }
    }
}
