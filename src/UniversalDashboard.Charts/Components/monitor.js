import React, { useRef, useState, useEffect } from 'react'
import ToolBar from './toolbar'
import { Layout } from 'antd/es'
import SettingsPanel from './settingsPanel'
import Monitor from './instance'

import { MonitorProvider } from './api/MonitorState'


export default ({ content, ...props }) => {
  const { Content } = Layout

  return (
    <MonitorProvider>
      <SettingsPanel />
      <Layout
        style={{
          backgroundColor: 'inherit',
          border: '2px solid rgba(0, 0, 0, 0.08)',
        }}
      >
        <Layout style={{ backgroundColor: 'inherit' }}>
          <ToolBar />
          <Content
            style={{
              backgroundColor: 'inherit',
              overflow: 'hidden',
              padding: 48,
            }}
          >
            <Monitor {...props} />
          </Content>
        </Layout>
      </Layout>
    </MonitorProvider>
  )
}
