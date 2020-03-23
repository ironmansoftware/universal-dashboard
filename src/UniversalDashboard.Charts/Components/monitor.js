import React, { useRef, useState, useEffect } from 'react'
import ToolBar from './parts/toolbar'
import { Layout } from 'antd/es'
import SettingsPanel from './settingsPanel'
import Monitor from './instance'
import { useThemeUI } from 'theme-ui'

import { MonitorProvider } from './api/MonitorState'

export default ({ content, ...props }) => {
  const context = useThemeUI()
  const { theme, colorModes } = context
  return (
    <MonitorProvider>
      <SettingsPanel />
      <Layout
        style={{
          backgroundColor: 'transparent',
          border: '2px solid rgba(0, 0, 0, 0.08)',
        }}
      >
        <Layout style={{ backgroundColor: colorModes === "light" ? theme.chart.light.background.fill : theme.chart.dark.background.fill }}>
          <ToolBar />
          {/* <h4 style={{ margin: 16, color: colorModes === "lig3ht" ? theme.chart.light.title.fill : theme.chart.dark.title.fill }}>{props.title}</h4> */}
          <Monitor {...props} />
        </Layout>
      </Layout>
    </MonitorProvider>
  )
}
