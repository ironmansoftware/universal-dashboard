import React, { Suspense, useState, useEffect } from 'react'

import { getApiPath, getDashboardId } from './config.jsx'
import PubSub from 'pubsub-js'
import { HubConnectionBuilder, LogLevel } from '@microsoft/signalr'
import { ThemeProvider, StyledEngineProvider, createTheme, adaptV4Theme } from '@mui/material/styles';
import toaster from './services/toaster'
import copy from 'copy-to-clipboard'
import useErrorBoundary from 'use-error-boundary';
import { AppContext } from './app-context';
import { useIdleTimer } from 'react-idle-timer';
import Button from '@mui/material/Button'
import ReactInterval from 'react-interval';
import { Alert, AlertTitle, CssBaseline } from "@mui/material";

const dashboardId = getDashboardId();

var connection

function connectWebSocket(sessionId, location, setLoading, history) {
  if (connection) {
    setLoading(false)
  }

  connection = new HubConnectionBuilder()
    .withUrl(getApiPath() + `/dashboardhub?dashboardId=${dashboardId}`)
    .configureLogging(LogLevel.Information)
    .build()

  connection.on('setState', json => {

    var data = JSON.parse(json);

    PubSub.publish(data.componentId, {
      type: 'setState',
      state: data.state,
    })
  })

  connection.on('showToast', json => {
    var model = JSON.parse(json);
    toaster.show(model)
  })

  connection.on('showError', json => {
    var model = JSON.parse(json);
    toaster.error(model)
  })

  connection.on('hideToast', id => {
    toaster.hide(id)
  })

  connection.on('requestState', json => {

    var data = JSON.parse(json)

    if (!PubSub.publish(data.componentId, {
      type: 'requestState',
      requestId: data.requestId,
    })) {
      // no component registered with this ID
      UniversalDashboard.post(`/api/internal/component/element/sessionState/${data.requestId}`, {});
    }
  })

  connection.on('invoke', json => {
    var data = JSON.parse(json)

    PubSub.publish(data.id, {
      type: 'invoke',
      data: data,
    })
  })

  connection.on('invokeMethod', json => {
    var data = JSON.parse(json)

    PubSub.publish(data.id, {
      ...data,
      type: 'invokeMethod',
    })
  })

  connection.on('removeElement', json => {

    var data = JSON.parse(json);

    PubSub.publish(data.componentId, {
      type: 'removeElement',
      componentId: data.componentId,
      parentId: data.parentId,
    })
  })

  connection.on('clearElement', componentId => {
    PubSub.publish(componentId, {
      type: 'clearElement',
      componentId: componentId,
    })
  })

  connection.on('syncElement', componentId => {
    PubSub.publish(componentId, {
      type: 'syncElement',
      componentId: componentId,
    })
  })

  connection.on('testForm', componentId => {
    PubSub.publish(componentId, {
      type: 'testForm',
      componentId: componentId,
    })
  })

  connection.on('addElement', json => {
    var data = JSON.parse(json);

    PubSub.publish(data.componentId, {
      type: 'addElement',
      componentId: data.componentId,
      elements: data.elements,
    })
  })

  connection.on('showModal', json => {
    var props = JSON.parse(json);
    PubSub.publish('modal.open', props)
  })

  connection.on('closeModal', () => {
    PubSub.publish('modal.close', {})
  })

  connection.on('redirect', json => {
    var data = JSON.parse(json);

    if (data.url.startsWith('/')) {
      history.push(data.url);
    }
    else if (data.openInNewWindow) {
      window.open(data.url)
    } else {
      window.location.href = data.url
    }
  })

  connection.on('refresh', () => {
    window.location.reload();
  })

  connection.on('select', json => {

    var data = JSON.parse(json);
    document.getElementById(data.id).focus()
    if (data.scrollToElement) {
      document.getElementById(data.id).scrollIntoView()
    }
  })

  connection.on('invokejavascript', jsscript => {
    eval(jsscript)
  })

  connection.on('clipboard', json => {

    var data = JSON.parse(json);
    try {
      let isCopyed = data.data !== null || data !== '' ? copy(data.data) : false
      if (data.toastOnSuccess && isCopyed) {
        toaster.show({
          message: 'Copied to clipboard',
        })
      }
    } catch (err) {
      if (data.toastOnError) {
        toaster.show({
          message: 'Unable to copy to clipboard',
        })
      }
    }
  })

  connection.on('download', json => {
    var data = JSON.parse(json);

    var element = document.createElement('a');
    element.setAttribute('href', `data:${data.contentType};charset=utf-8, ` + encodeURIComponent(data.stringData));
    element.setAttribute('download', data.fileName);
    document.body.appendChild(element);
    element.click();
    document.body.removeChild(element);
  })

  connection.on('write', message => {
    PubSub.publish('write', message)
  })

  connection.on('setConnectionId', id => {
    UniversalDashboard.connectionId = id
    setLoading(false)
  })

  connection.on('log', message => {
    console.log(message);
  })


  PubSub.subscribe('element-event', function (e, data) {
    if (data.type === 'clientEvent') {
      connection
        .invoke(
          'clientEvent',
          data.eventId,
          data.eventName,
          data.eventData,
          location,
        )
        .catch(function (e) {
          toaster.show({
            message: e.message,
            icon: 'fa fa-times-circle',
            iconColor: '#FF0000',
          })
        })
    }

    if (data.type === 'unregisterEvent') {
      connection.invoke('unregisterEvent', data.eventId)
    }

    if (data.type === 'getState') {
      connection.invoke('getState', data.requestId, JSON.stringify(data.state))
    }
  })

  connection.start().then(x => {
    window.UniversalDashboard.webSocket = connection
    connection.invoke('setSessionId', sessionId)
  })

  connection.onreconnecting((error) => {
    console.log("Web socket reconnecting: " + error.message);
  })

  connection.onclose((error) => {
    console.log("Web socket closed: " + error.message);
    connectWebSocket(sessionId, location, setLoading, history)
  })

  connection.onreconnected((connectionId) => {
    console.log("Web socket reconnected: " + connectionId);
  })
}

function loadStylesheet(url) {
  var styles = document.createElement('link')
  styles.rel = 'stylesheet'
  styles.type = 'text/css'
  styles.media = 'screen'
  styles.href = url
  document.getElementsByTagName('head')[0].appendChild(styles)
}

function loadJavascript(url, onLoad) {
  var jsElm = document.createElement('script')
  jsElm.onload = onLoad
  jsElm.type = 'application/javascript'
  jsElm.src = url
  document.body.appendChild(jsElm)
}

function getLocation(setLocation) {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function (position) {
      var name = 'location'

      var positionJson = {
        coords: {
          accuracy: position.coords.accuracy,
          altitude: position.coords.altitude,
          altitudeAccuracy: position.coords.altitudeAccuracy,
          heading: position.coords.heading,
          latitude: position.coords.latitude,
          longitude: position.coords.longitude,
          speed: position.coords.speed,
        },
        timestamp: new Date(position.timestamp).toJSON(),
      }

      var value = JSON.stringify(positionJson)
      value = btoa(value)
      document.cookie = name + '=' + (value || '') + '; path=/'

      setLocation(value)
    })
  }
}

function Dashboard({ history }) {
  const { ErrorBoundary, didCatch, error } = useErrorBoundary()
  const [dashboard, setDashboard] = useState(null)
  const [dashboardError, setDashboardError] = useState(null)
  const [loading, setLoading] = useState(true)
  const [location, setLocation] = useState(null);
  const [roles, setRoles] = useState([]);
  const [user, setUser] = useState('');
  const [windowsAuth, setWindowsAuth] = useState(false);
  const [idleTimeout, setIdleTimeout] = useState(Number.MAX_VALUE);
  const [sessionTimedOut, setSessionTimedOut] = useState(false);
  const [sessionId, setSessionId] = useState(null);
  const defaultTheme = localStorage.getItem('theme');
  const [theme, setTheme] = useState(defaultTheme ? defaultTheme : 'light');

  useIdleTimer({
    crossTab: false,
    stopOnIdle: true,
    onIdle: () => {
      if (!sessionId) return;
      UniversalDashboard.disableFetchService();
      UniversalDashboard.publish('modal.open', {
        header: [<div />],
        content: [<div id="idleTimeout">This page has been disabled due to it being idle.</div>],
        footer: [<Button onClick={() => window.location.reload()}>Refresh Page</Button>]
      })
    },
    timeout: 1000 * 60 * idleTimeout
  })

  const checkSession = () => {
    if (!sessionId) return;
    UniversalDashboard.get(`/api/internal/session/${sessionId}`, () => { }, null, () => {
      UniversalDashboard.onSessionTimedOut();
      setSessionTimedOut(true);
    })
  }



  const loadData = () => {
    UniversalDashboard.get(
      '/api/internal/dashboard',
      function (json) {
        var dashboard = json.dashboard

        if (dashboard.error) {
          setDashboardError(dashboard.error);
          return;
        }

        if (dashboard.stylesheets) dashboard.stylesheets.map(loadStylesheet)

        if (dashboard.scripts) dashboard.scripts.map(loadJavascript)

        connectWebSocket(json.sessionId, location, setLoading, history)
        UniversalDashboard.sessionId = json.sessionId;
        UniversalDashboard.design = dashboard.design

        setDashboard(dashboard);

        if (!defaultTheme) {
          setTheme(dashboard.defaultTheme);
        }

        if (json.roles) {
          setRoles(json.roles);
        }

        if (json.user) {
          setUser(json.user);
        }

        if (json.idleTimeout)
          setIdleTimeout(json.idleTimeout);

        setWindowsAuth(json.windowsAuth);

        if (dashboard.geolocation) {
          getLocation(setLocation)
        }

        setSessionId(json.sessionId);
      },
      history,
    )
  }


  useEffect(() => {
    if (dashboard) return

    try {
      loadData()
    } catch (err) {
      setDashboardError(err)
    }
  })

  if (didCatch) {
    return <Alert variant="standard" severity="error">
      <AlertTitle>{`Error rendering component`}</AlertTitle>
      {error}
    </Alert>
  }

  if (dashboardError) {
    return <Alert variant="standard" severity="error">
      <AlertTitle>{`Error with dashboard script`}</AlertTitle>
      {error}
    </Alert>
  }

  if (loading) {
    return <div />
  }

  try {
    var component = UniversalDashboard.renderDashboard({
      dashboard,
      history,
      roles,
      user,
      windowsAuth
    })

    var dashboardTheme = JSON.parse(dashboard.theme);

    if (dashboard.theme && theme === "light" && dashboardTheme.light) {
      dashboardTheme = dashboardTheme.light;
    }
    else if (dashboard.theme && theme === "dark" && dashboardTheme.dark) {
      dashboardTheme = dashboardTheme.dark;
    }

    const muiTheme = createTheme(adaptV4Theme({
      palette: {
        mode: theme
      },
      ...dashboardTheme
    }));

    const appContext = {
      theme,
      setTheme
    }

    return (
      <AppContext.Provider value={appContext}>
        <ErrorBoundary>
          <>
            <StyledEngineProvider injectFirst>
              <ThemeProvider theme={muiTheme}>
                <CssBaseline />
                {component}
              </ThemeProvider>
            </StyledEngineProvider>
          </>
          <ReactInterval timeout={5000} enabled={!sessionTimedOut} callback={checkSession} />
        </ErrorBoundary>
      </AppContext.Provider>
    );
  } catch (err) {
    setDashboardError(err)
  }

  return null
}

export default Dashboard
