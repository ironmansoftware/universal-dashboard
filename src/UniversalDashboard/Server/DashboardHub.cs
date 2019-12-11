using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Caching.Memory;
using Newtonsoft.Json;
using NLog;
using NLog.Fluent;
using UniversalDashboard.Execution;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;
using UniversalDashboard.Models.Basics;
using UniversalDashboard.Services;
using System.Text;
using UniversalDashboard.Models.Enums;
using Microsoft.CSharp.RuntimeBinder;

namespace UniversalDashboard
{
    public static class DashboardHubContextExtensions
    {
        public static async Task ShowModal(this IHubContext<DashboardHub> hub, string clientId, Modal modal)
        {
            await hub.Clients.Client(clientId).SendAsync("showModal", modal);
        }
        public static async Task CloseModal(this IHubContext<DashboardHub> hub, string clientId)
        {
            await hub.Clients.Client(clientId).SendAsync("closeModal");
        }
        public static async Task ShowToast(this IHubContext<DashboardHub> hub, string clientId, object toast)
        {
            await hub.Clients.Client(clientId).SendAsync("showToast", toast);
        }
        public static async Task ShowToast(this IHubContext<DashboardHub> hub, object toast)
        {
            await hub.Clients.All.SendAsync("showToast", toast);
        }
        public static async Task HideToast(this IHubContext<DashboardHub> hub, string clientId, string id)
        {
            await hub.Clients.Client(clientId).SendAsync("hideToast", id);
        }
        public static async Task RequestState(this IHubContext<DashboardHub> hub, string clientId, string componentId, string requestId)
        {
            await hub.Clients.Client(clientId).SendAsync("requestState", componentId, requestId);
        }

        public static async Task Redirect(this IHubContext<DashboardHub> hub, string clientId, string url, bool newWindow)
        {
            await hub.Clients.Client(clientId).SendAsync("redirect", url, newWindow);
        }

        public static async Task Select(this IHubContext<DashboardHub> hub, string clientId, string ParameterSetName, string ID, bool scrollToElement)
        {
            await hub.Clients.Client(clientId).SendAsync("select", ParameterSetName, ID, scrollToElement);
        }

        public static async Task InvokeJavaScript(this IHubContext<DashboardHub> hub, string clientId, string JavaScript)
        {
            await hub.Clients.Client(clientId).SendAsync("invokejavascript", JavaScript);
        }

        public static async Task Clipboard(this IHubContext<DashboardHub> hub, string clientId, string Data, bool toastOnSuccess, bool toastOnError)
        {
            await hub.Clients.Client(clientId).SendAsync("clipboard", Data, toastOnSuccess ,toastOnError);
        }

        public static async Task SetState(this IHubContext<DashboardHub> hub, string componentId, Element state)
        {
            await hub.Clients.All.SendAsync("setState", componentId, state);
        }

        public static async  Task SetState(this IHubContext<DashboardHub> hub, string clientId, string componentId, Element state)
        {
            await hub.Clients.Client(clientId).SendAsync("setState", componentId, state);
        }

        public static async Task AddElement(this IHubContext<DashboardHub> hub, string parentComponentId, object[] element)
        {
            await hub.Clients.All.SendAsync("addElement", parentComponentId, element);
        }

        public static async  Task AddElement(this IHubContext<DashboardHub> hub, string clientId, string parentComponentId, object[] element)
        {
            await hub.Clients.Client(clientId).SendAsync("addElement", parentComponentId, element);
        }

        public static async Task RemoveElement(this IHubContext<DashboardHub> hub, string clientId, string componentId, string parentId)
        {
            await hub.Clients.Client(clientId).SendAsync("removeElement", componentId, parentId);
        }

        public static async Task RemoveElement(this IHubContext<DashboardHub> hub, string componentId, string parentId)
        {
            await hub.Clients.All.SendAsync("removeElement", componentId, parentId);
        }

        public static async Task ClearElement(this IHubContext<DashboardHub> hub, string clientId, string componentId)
        {
            await hub.Clients.Client(clientId).SendAsync("clearElement", componentId);
        }

        public static async Task ClearElement(this IHubContext<DashboardHub> hub, string componentId)
        {
            await hub.Clients.All.SendAsync("clearElement", componentId);
        }

        public static async Task SyncElement(this IHubContext<DashboardHub> hub, string clientId, string componentId)
        {
            await hub.Clients.Client(clientId).SendAsync("syncElement", componentId);
        }

        public static async Task SyncElement(this IHubContext<DashboardHub> hub, string componentId)
        {
            await hub.Clients.All.SendAsync("syncElement", componentId);
        }

        // PS Host

        public static async Task Write(this IHubContext<DashboardHub> hub, string clientId, string message, MessageType messageType)
        {
            await hub.Clients.Client(clientId).SendAsync("write", message, messageType);
        }
    }

    public class DashboardHub : Hub {
        private IExecutionService _executionService;
        private readonly StateRequestService _stateRequestService;
        private readonly ConnectionManager _connectionManager;
        private readonly IDashboardService _dashboardService;
        private readonly IMemoryCache _memoryCache;
        private static readonly Logger _logger = LogManager.GetLogger(nameof(DashboardHub));

        public DashboardHub(IExecutionService executionService, ConnectionManager connectionManager, StateRequestService stateRequestService, IDashboardService dashboardService, IMemoryCache memoryCache) {
            Log.Debug("DashboardHub constructor");

            _executionService = executionService;
            _stateRequestService = stateRequestService;
            _connectionManager = connectionManager;
            _dashboardService = dashboardService;
            _memoryCache = memoryCache;
        }

        public override async Task OnConnectedAsync()
        {
            await Task.FromResult(0);
        }

        public override async Task OnDisconnectedAsync(Exception exception)
        {
            await Task.FromResult(0);
            if (exception == null) {
                Log.Debug("Disconnected");
            }
            else
            {
                Log.Error(exception.Message);
            }

            var sessionId = _connectionManager.GetSessionId(Context.ConnectionId);
            if (sessionId != null)
            {
                _dashboardService.EndpointService.SessionManager.EndSession(sessionId as string);
            }

            _connectionManager.RemoveConnection(Context.ConnectionId);
        }

        public async Task SetSessionId(string sessionId)
        {
            Log.Debug($"SetSessionId({sessionId})");

            _connectionManager.AddConnection(new Connection { Id = Context.ConnectionId, SessionId = sessionId });
            _dashboardService.EndpointService.SessionManager.StartSession(sessionId);

            await Clients.Client(Context.ConnectionId).SendAsync("setConnectionId", Context.ConnectionId);
        }

        public Task Reload()
        {
            Log.Debug($"Reload()");

            return Clients.All.SendAsync("reload");
        }

        public async Task RequestStateResponse(string requestId, Element state)
        {
            await Task.FromResult(0);

            _stateRequestService.Set(requestId, state);
        }

        public async Task UnregisterEvent(string eventId)
        {
            await Task.CompletedTask;

            Log.Debug($"UnregisterEvent() {eventId}");

            var sessionId = _connectionManager.GetSessionId(Context.ConnectionId);
            if (sessionId != null)
            {
                _dashboardService.EndpointService.Unregister(eventId, sessionId);
            }
            else
            {
                _dashboardService.EndpointService.Unregister(eventId, null);
            }
        }

        public async Task ClientEvent(string eventId, string eventName, string eventData, string location) {
            _logger.Debug($"ClientEvent {eventId} {eventName}");

            var variables = new Dictionary<string, object>();
            var userName = Context.User?.Identity?.Name;

            if (!string.IsNullOrEmpty(userName))
            {
                variables.Add("user", userName);
            }

            if (!string.IsNullOrEmpty(location)) {
                location = Encoding.UTF8.GetString(Convert.FromBase64String(location));
                var locationObject = JsonConvert.DeserializeObject<Location>(location);
                variables.Add("Location", locationObject);
			}

            if (bool.TryParse(eventData, out bool data))
            {
                variables.Add("EventData", data);
            }
            else
            {
                variables.Add("EventData", eventData);
            }

            variables.Add("UDConnectionManager", _connectionManager);
            variables.Add("EventId", eventId);
            variables.Add("MemoryCache", _memoryCache);

            try
            {
                var sessionId = _connectionManager.GetSessionId(Context.ConnectionId);

                var endpoint = _dashboardService.EndpointService.Get(eventId, sessionId);
                if (endpoint == null)
                {
                    _logger.Warn($"Endpoint {eventId} not found.");
                    throw new Exception($"Endpoint {eventId} not found.");
                }

                var executionContext = new ExecutionContext(endpoint, variables, new Dictionary<string, object>(), Context.User);
                executionContext.ConnectionId = Context.ConnectionId;
                executionContext.SessionId = sessionId;

                try
                {
                    dynamic result = await _executionService.ExecuteEndpointAsync(executionContext, endpoint);
                    if (result.Error is Error error)
                    {
#pragma warning disable CS4014 // Because this call is not awaited, execution of the current method continues before the call is completed
                        Clients.Client(Context.ConnectionId).SendAsync("showError", new { message = error.Message });
#pragma warning restore CS4014 // Because this call is not awaited, execution of the current method continues before the call is completed
                    }

                }
                catch (RuntimeBinderException)
                {

                }
                catch (Exception ex)
                {
                    _logger.Error("Failed to execute action. " + ex.Message);
                    throw;
                }
            }
            catch (Exception ex)
            {
                _logger.Warn($"Failed to execute endpoint. " + ex.Message);
                throw;
            }
        }
    }
}
