using System.Collections;
using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Models;

namespace UniversalDashboard
{
    public class DashboardCallbackService : IDashboardCallbackService
    {
        private readonly IHubContext<DashboardHub> _hubContext;

        public DashboardCallbackService(IHubContext<DashboardHub> hubContext)
        {
            _hubContext = hubContext;
        }

        public Task AddElement(string parentComponentId, object[] element)
        {
            return _hubContext.AddElement(parentComponentId, element);
        }

        public Task AddElement(string clientId, string parentComponentId, object[] element)
        {
            return _hubContext.AddElement(clientId, parentComponentId, element);
        }

        public Task ClearElement(string clientId, string componentId)
        {
            return _hubContext.ClearElement(clientId, componentId);
        }

        public Task ClearElement(string componentId)
        {
            return _hubContext.ClearElement(componentId);
        }

        public Task Clipboard(string clientId, string Data, bool toastOnSuccess, bool toastOnError)
        {
            return _hubContext.Clipboard(clientId, Data, toastOnSuccess, toastOnError);
        }

        public Task CloseModal(string clientId)
        {
            return _hubContext.CloseModal(clientId);
        }

        public Task HideToast(string clientId, string id)
        {
            return _hubContext.HideToast(clientId, id);
        }

        public Task InvokeJavaScript(string clientId, string JavaScript)
        {
            return _hubContext.InvokeJavaScript(clientId, JavaScript);
        }

        public Task Redirect(string clientId, string url, bool newWindow)
        {
            return _hubContext.Redirect(clientId, url, newWindow);
        }

        public Task RemoveElement(string clientId, string componentId, string parentId)
        {
            return _hubContext.RemoveElement(clientId, componentId, parentId);
        }

        public Task RemoveElement(string componentId, string parentId)
        {
            return _hubContext.RemoveElement(componentId, parentId);
        }

        public Task RequestState(string clientId, string componentId, string requestId)
        {
            return _hubContext.RequestState(clientId, componentId, requestId);
        }

        public Task Select(string clientId, string ParameterSetName, string ID, bool scrollToElement)
        {
            return _hubContext.Select(clientId, ParameterSetName, ID, scrollToElement);
        }

        public Task SetState(string componentId, Hashtable state)
        {
            return _hubContext.SetState(componentId, state);
        }

        public Task SetState(string clientId, string componentId, Hashtable state)
        {
            return _hubContext.SetState(clientId, componentId, state);
        }

        public Task ShowModal(string clientId, Modal modal)
        {
            return _hubContext.ShowModal(clientId, modal);
        }

        public Task ShowToast(string clientId, object toast)
        {
            return _hubContext.ShowToast(clientId, toast);
        }

        public Task ShowToast(object toast)
        {
            return _hubContext.ShowToast(toast);
        }

        public Task SyncElement(string clientId, string componentId)
        {
            return _hubContext.SyncElement(clientId, componentId);
        }

        public Task SyncElement(string componentId)
        {
            return _hubContext.SyncElement(componentId);
        }
    }
}