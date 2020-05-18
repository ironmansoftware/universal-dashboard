import React, { Suspense, useState, useEffect } from 'react'

import { getApiPath } from './config.jsx'
import PubSub from 'pubsub-js'
import { HubConnectionBuilder, LogLevel } from '@microsoft/signalr'
import { ThemeProvider } from 'theme-ui'
import { ColorModeProvider } from '@theme-ui/color-modes'
import { base } from '@theme-ui/presets'
import toaster from './services/toaster'
import LazyElement from './basics/lazy-element.jsx'
import copy from 'copy-to-clipboard'
import ErrorCard from './../Components/framework/error-card'

function getMeta(metaName) {
  const metas = document.getElementsByTagName('meta');

  for (let i = 0; i < metas.length; i++) {
    if (metas[i].getAttribute('name') === metaName) {
      return metas[i].getAttribute('content');
    }
  }

  return '';
}

const dashboardId = getMeta('ud-dashboard');

var connection

function connectWebSocket(sessionId, location, setLoading, history) {
  if (connection) {
    setLoading(false)
  }

  connection = new HubConnectionBuilder()
    .withUrl(getApiPath() + `/dashboardhub?dashboardId=${dashboardId}`)
    .configureLogging(LogLevel.Information)
    .build()

  connection.on('reload', data => {
    window.location.reload(true)
  })

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

    PubSub.publish(data.componentId, {
      type: 'requestState',
      requestId: data.requestId,
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

    if (data.url.startsWith('/'))
    {
       history.push(data.url);
    }
    else if (data.openInNewWindow) {
      window.open(data.url)
    } else {
      window.location.href = data.url
    }
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

  connection.on('write', message => {
    PubSub.publish('write', message)
  })

  connection.on('setConnectionId', id => {
    UniversalDashboard.connectionId = id
    setLoading(false)
  })

  PubSub.subscribe('element-event', function(e, data) {
    if (data.type === 'requestStateResponse') {
      connection.invoke('requestStateResponse', data.requestId, data.state)
    }

    if (data.type === 'clientEvent') {
      connection
        .invoke(
          'clientEvent',
          data.eventId,
          data.eventName,
          data.eventData,
          location,
        )
        .catch(function(e) {
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
  })

  connection.start().then(x => {
    window.UniversalDashboard.webSocket = connection
    connection.invoke('setSessionId', sessionId)
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

var sessionCheckToken = null;

const checkSession = () => {
  UniversalDashboard.get(`/api/internal/session/${UniversalDashboard.sessionId}`, () => {}, null, () => {
      UniversalDashboard.sessionTimedOut = true;
      UniversalDashboard.onSessionTimedOut();
      clearInterval(sessionCheckToken);
  })
}

function getLocation(setLocation) {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
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
  const [dashboard, setDashboard] = useState(null)
  const [hasError, setHasError] = useState(false)
  const [error, setError] = useState(null)
  const [loading, setLoading] = useState(true)
  const [location, setLocation] = useState(null)

  const loadData = () => {
    UniversalDashboard.get(
      '/api/internal/dashboard',
      function(json) {
        var dashboard = json.dashboard

        if (dashboard.error) {
          setError(dashboard.error);
          setHasError(true);
          return;
        }

        if (dashboard.stylesheets) dashboard.stylesheets.map(loadStylesheet)

        if (dashboard.scripts) dashboard.scripts.map(loadJavascript)

        connectWebSocket(json.sessionId, location, setLoading, history)
        UniversalDashboard.sessionId = json.sessionId;

        sessionCheckToken = setInterval(checkSession, 5000);

        UniversalDashboard.design = dashboard.design

        setDashboard(dashboard)

        if (dashboard.geolocation) {
          getLocation(setLocation)
        }
      },
      history,
    )
  }


  useEffect(() => {
    if (dashboard) return

    try {
      loadData()
    } catch (err) {
      setError(err)
      setHasError(true)
    }
  })

  if (hasError) {
    return <ErrorCard message={error} />
  }

  if (loading) {
    return <div />
  }

  try {
    var component = UniversalDashboard.renderDashboard({
      dashboard: dashboard,
      history: history,
    })

    var pluginComponents = UniversalDashboard.provideDashboardComponents()

    let theme = {      
        colors : {
        primary: "#df5656",
        secondary: "#fdc533",
        background: "#c1c1c1",
        text: "#333",
        muted: "#d6d6d6"
    }
  }

    // const { colors, modes, ...rest } = dashboard.themes[0].definition
    // let theme = {
    //   ...base,
    //   colors: {
    //     ...colors,
    //     modes: {
    //       ...modes,
    //     },
    //   },
    //   ...rest,
    //   styles: {
    //     ...base.styles,
    //     h1: {
    //       ...base.styles.h1,
    //       fontSize: [4, 5, 6],
    //     },
    //   },
    // }
    
    return (
      <ThemeProvider theme={theme}>
        <ColorModeProvider>{[component, pluginComponents]}</ColorModeProvider>
      </ThemeProvider>
    )
  } catch (err) {
    setError(err)
    setHasError(true)
  }

  return null
}

export default Dashboard
