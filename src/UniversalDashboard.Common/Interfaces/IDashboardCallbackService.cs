using System.Collections;
using System.Threading.Tasks;
using UniversalDashboard.Models;

namespace UniversalDashboard.Interfaces 
{
    public interface IDashboardCallbackService
    {
        Task ShowModal(string clientId, Modal modal);
        Task CloseModal(string clientId);
        Task ShowToast(string clientId, object toast);
        Task ShowToast(object toast);
        Task HideToast(string clientId, string id);
        Task RequestState(string clientId, string componentId, string requestId);
        Task Redirect(string clientId, string url, bool newWindow);
        Task Select(string clientId, string ParameterSetName, string ID, bool scrollToElement);
        Task InvokeJavaScript(string clientId, string JavaScript);
        Task Clipboard(string clientId, string Data, bool toastOnSuccess, bool toastOnError);
        Task SetState(string componentId, Hashtable state);
        Task SetState(string clientId, string componentId, Hashtable state);
        Task AddElement(string parentComponentId, object[] element);
        Task AddElement(string clientId, string parentComponentId, object[] element);
        Task RemoveElement(string clientId, string componentId, string parentId);
        Task RemoveElement(string componentId, string parentId);
        Task ClearElement(string clientId, string componentId);
        Task ClearElement(string componentId);
        Task SyncElement(string clientId, string componentId);
        Task SyncElement(string componentId);
    }
}
