export function getApiPath() {
    return "";
}

export function getWsApiPath() {
    var protocol = "ws://";
    if (window.location.protocol.toLowerCase().startsWith("https")) {
        protocol = "wss://";
    }

    return protocol + window.location.hostname + (window.location.port ? ':' + window.location.port : ''); 
}

function getMeta(metaName) {
    const metas = document.getElementsByTagName('meta');
  
    for (let i = 0; i < metas.length; i++) {
      if (metas[i].getAttribute('name') === metaName) {
        return metas[i].getAttribute('content');
      }
    }
  
    return '';
  }

export function getDashboardId() {
    var dashboardId = localStorage.getItem("ud-dashboard");
    if (!dashboardId || dashboardId === '')
    {
        dashboardId = getMeta('ud-dashboard');
    }

    return dashboardId;
}