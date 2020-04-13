using Microsoft.Extensions.Caching.Memory;
using System;
using System.Threading;
using System.Collections;
using UniversalDashboard.Interfaces;

namespace UniversalDashboard.Services
{
    public class StateRequestService : IStateRequestService
    {
        private readonly IMemoryCache _memoryCache;

        public AutoResetEvent EventAvailable { get; }= new AutoResetEvent(false);

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
