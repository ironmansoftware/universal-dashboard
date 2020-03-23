import React, { useState } from 'react'
import { Table, Drawer, Button } from 'antd/es'
import { DownloadOutlined } from '@ant-design/icons'
import { downloadCSV, generateCsvString } from './utils'
import { useMonitor } from './api/MonitorState'
import { Spin, Row, Col, Switch } from 'antd'
import Form from './settingsForm'

export default ({ visible }) => {
  const [state, dispatch] = useMonitor()
  const { settings, data, theme } = state

  const onClose = () =>
    dispatch({ type: 'SET_SETTINGS_VISIBILITY', payload: false })

  const download = () => downloadCSV(data, 'monitorData')

  const createTable = () => {
    const columns = Object.keys(data[0]).map(column => ({
      title: `${column[0].toUpperCase()}${column.substring(1)}`,
      dataIndex: `${column.toLowerCase()}`,
    }))

    return <Table dataSource={data} columns={columns} bordered size="small" pagination={{defaultPageSize: 20}}/>
  }

  return (
    <Drawer
      title="Settings"
      placement="right"
      closable={true}
      width="80vw"
      onClose={onClose}
      visible={settings.visible}
      footer={
        <Button onClick={download} disabled={!data[0]} type="primary" icon={<DownloadOutlined />}>
          Download
        </Button>
      }
    >
      <Row>
        <Col span={6}>
          <Form />
        </Col>
        <Col span={18}>
            <Spin spinning={!data[0]} tip="Loading data" >
              {!data[0] ? [] : createTable()}
            </Spin>
        </Col>
      </Row>
    </Drawer>
  )
}