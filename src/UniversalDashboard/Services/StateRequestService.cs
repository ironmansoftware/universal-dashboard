using Microsoft.Extensions.Caching.Memory;
using UniversalDashboard.Models.Basics;
using System;
using System.Threading;
using System.Collections;

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

        public void Set(string requestId, Hashtable state)
        {
            _memoryCache.Set(requestId, state, TimeSpan.FromSeconds(5));
            EventAvailable.Set();
        }

        public bool TryGet(string requestId, out Hashtable element)
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
