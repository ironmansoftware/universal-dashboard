import React, { useState, useEffect } from 'react'
import UdDashboard from './ud-dashboard.jsx'
import { BrowserRouter as Router, Route } from 'react-router-dom'
// import Layout from './blocks/layout'
import { loadTheme, useFramework, loadPlugin, loadpluginRoutes } from './utils/index.js'

var regex = new RegExp(
  '^' + window.baseUrl + '(?!.*(/login))(?!.*(/license)).*$',
)

export default function App(props){
  useFramework()

  useEffect(() => {
    let isCurrent = true
    if (isCurrent) {
      loadTheme()
      loadPlugin()
    }
    return () => (isCurrent = false)
  })

  return (
    <Router>
      <div className="ud-dashboard">
        {loadpluginRoutes()}
        <Route path={regex} component={UdDashboard} />
      </div>
    </Router>
  )
}
