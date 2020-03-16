import React from 'react'
import { Col, Row, Layout } from 'antd/es'
import SettingsForm from './settingsForm'
import { useMonitor } from './api/MonitorState'

const { Sider } = Layout

export default ({ visible }) => {
  const [state, dispatch] = useMonitor()
  const { settings } = state
  return (
    <Sider
      trigger={null}
      collapsible
      collapsed={settings.collapsed}
      collapsedWidth={0}
      defaultCollapsed={true}
      width="40%"
      theme="light"
      style={{ backgroundColor: 'inherit' }}
    >
      <Row
        style={{
          height: '100%',
          alignItems: 'center',
          boxShadow: '-7px 0px 21px -15px rgba(0,0,0,0.75)',
        }}
      >
        <Col>
          <SettingsForm />
        </Col>
      </Row>
    </Sider>
  )
}
