import React, { Suspense, useState, useEffect } from 'react'

import { getApiPath } from 'config'
import PubSub from 'pubsub-js'
import { HubConnectionBuilder, LogLevel } from '@aspnet/signalr'
import { ThemeProvider } from 'theme-ui'
import { ColorModeProvider } from '@theme-ui/color-modes'
import { base } from '@theme-ui/presets'
import toaster from './services/toaster'
import LazyElement from './basics/lazy-element.jsx'
import copy from 'copy-to-clipboard'

var connection

function connectWebSocket(sessionId, location, setLoading, history) {
  if (connection) {
    setLoading(false)
  }

  connection = new HubConnectionBuilder()
    .withUrl(getApiPath() + '/dashboardhub')
    .configureLogging(LogLevel.Information)
    .build()

  connection.on('reload', data => {
    window.location.reload(true)
  })

  connection.on('setState', (componentId, state) => {
    PubSub.publish(componentId, {
      type: 'setState',
      state: state,
    })
  })

  connection.on('showToast', model => {
    toaster.show(model)
  })

  connection.on('showError', model => {
    toaster.error(model)
  })

  connection.on('hideToast', id => {
    toaster.hide(id)
  })

  connection.on('requestState', (componentId, requestId) => {
    PubSub.publish(componentId, {
      type: 'requestState',
      requestId: requestId,
    })
  })

  connection.on('removeElement', (componentId, parentId) => {
    PubSub.publish(componentId, {
      type: 'removeElement',
      componentId: componentId,
      parentId: parentId,
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

  connection.on('addElement', (componentId, elements) => {
    if (componentId == null) return

    PubSub.publish(componentId, {
      type: 'addElement',
      componentId: componentId,
      elements: elements,
    })
  })

  connection.on('showModal', props => {
    PubSub.publish('modal.open', props)
  })

  connection.on('closeModal', () => {
    PubSub.publish('modal.close', {})
  })

  connection.on('redirect', (url, newWindow) => {
    if (url.startsWith('/'))
    {
       history.push(url);
    }
    else if (newWindow) {
      window.open(url)
    } else {
      window.location.href = url
    }
  })

  connection.on('select', (ParameterSetName, ID, scrollToElement) => {
    if (ParameterSetName == 'ToTop') {
      window.scrollTo({ top: 0, behavior: 'smooth' })
    }
    if (ParameterSetName == 'Normal') {
      document.getElementById(ID).focus()
      if (scrollToElement) {
        document.getElementById(ID).scrollIntoView()
      }
    }
  })

  connection.on('invokejavascript', jsscript => {
    eval(jsscript)
  })

  connection.on('clipboard', (Data, toastOnSuccess, toastOnError) => {
    let data = Data
    try {
      let isCopyed = data !== null || data !== '' ? copy(data) : false
      if (toastOnSuccess && isCopyed) {
        toaster.show({
          message: 'Copied to clipboard',
        })
      }
    } catch (err) {
      if (toastOnError) {
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

function loadData(setDashboard, setLocation, history, location, setLoading) {
  UniversalDashboard.get(
    '/api/internal/dashboard',
    function(json) {
      var dashboard = json.dashboard

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

  useEffect(() => {
    if (dashboard) return

    try {
      loadData(setDashboard, setLocation, history, location, setLoading)
    } catch (err) {
      setError(err)
      setHasError(true)
    }
  })

  if (hasError) {
    return (
      <Suspense fallback={null}>
        <LazyElement
          component={{
            type: 'error',
            message: error.message,
            location: error.stackTrace,
          }}
        />
      </Suspense>
    )
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

    const { colors, modes, ...rest } = dashboard.themes[0].definition
    let theme = {
      ...base,
      colors: {
        ...colors,
        modes: {
          ...modes,
        },
      },
      ...rest,
      styles: {
        ...base.styles,
        h1: {
          ...base.styles.h1,
          fontSize: [4, 5, 6],
        },
      },
    }
    
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
