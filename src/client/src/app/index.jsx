import './public-path'
import '@babel/polyfill'
import React from 'react'
import { render } from 'react-dom'
import $ from 'jquery'
import 'whatwg-fetch'
import Promise from 'promise-polyfill'
import { UniversalDashboardService } from './services/universal-dashboard-service.jsx'
import App from './App'
import { getApiPath } from 'config'
import { ThemeProvider } from '@theme-ui/core'
import { ColorModeProvider } from '@theme-ui/color-modes'
import theme from './theme/theme'

window.react = require('react')
window['reactdom'] = require('react-dom')
window['reactrouterdom'] = require('react-router-dom')
window['themeuicore'] = require('@theme-ui/core')

// To add to window
if (!window.Promise) {
  window.Promise = Promise
}

window.UniversalDashboard = UniversalDashboardService
require('./component-registration')

render(
  <ThemeProvider theme={theme}>
    <ColorModeProvider >
      <App />
    </ColorModeProvider>
  </ThemeProvider>,
  document.getElementById('app'),
)
