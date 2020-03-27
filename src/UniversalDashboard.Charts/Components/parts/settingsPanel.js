/** @jsx jsx */
import React from 'react'
import { DownloadOutlined } from '@ant-design/icons'
import { downloadCSV } from '../utils'
import { useMonitor } from '../api/MonitorState'
// import Form from './settingsForm'
import {jsx} from 'theme-ui'

import Button from 'antd/es/button'
import 'antd/es/button/style'
import Drawer from 'antd/es/drawer'
import 'antd/es/drawer/style'
import Table from 'antd/es/table'
import 'antd/es/table/style'
import Spin from 'antd/es/spin'
import 'antd/es/spin/style'
import Row from 'antd/es/row'
import 'antd/es/row/style'
import Col from 'antd/es/col'
import 'antd/es/col/style'

export default ({ visible }) => {
  const [state, dispatch] = useMonitor()
  const { settings, data } = state

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
        <Button onClick={download} disabled={!data[0]} sx={{bg: 'primary', color: 'text'}} icon={<DownloadOutlined />}>
          Download
        </Button>
      }
    >
      <Row>
        <Col span={18}>
            <Spin spinning={!data[0]} tip="Loading data" >
              {!data[0] ? [] : createTable()}
            </Spin>
        </Col>
      </Row>
    </Drawer>
  )
}
