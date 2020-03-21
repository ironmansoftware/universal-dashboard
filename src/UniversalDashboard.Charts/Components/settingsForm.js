import React, { useState } from 'react'
import {
  Form,
  Switch,
  Tooltip
} from 'antd/es'
import { InfoCircleOutlined } from '@ant-design/icons'
import { useMonitor } from './api/MonitorState'

export default () => {
  const [{settings}, dispatch] = useMonitor()

  return (
      <Form
        labelCol={{
          span: 4,
        }}
        wrapperCol={{
          span: 14,
        }}
        layout="horizontal"
      >
        <Form.Item label="Show min.">
          <Switch
            onChange={() =>
              dispatch({
                type: 'SET_SETTINGS_SHOW_MIN',
                payload: !settings.statistics.showMin,
              })
            }
            style={{ marginRight: 24 }}
          />
          <Tooltip title="Show the minimum value that was reading." arrowPointAtCenter>
            <InfoCircleOutlined />
          </Tooltip>
        </Form.Item>

        <Form.Item label="Show max.">
          <Switch
            onChange={() =>
              dispatch({
                type: 'SET_SETTINGS_SHOW_MAX',
                payload: !settings.statistics.showMax,
              })
            }
             style={{ marginRight: 24 }}
          />
          <Tooltip title="Show the current maximum value that was reading." arrowPointAtCenter>
            <InfoCircleOutlined />
          </Tooltip>
        </Form.Item>

        <Form.Item label="Show avg.">
          <Switch
            onChange={() =>
              dispatch({
                type: 'SET_SETTINGS_SHOW_AVG',
                payload: !settings.statistics.showAvg,
              })
            }
             style={{ marginRight: 24 }}
          />
          <Tooltip title="Show current average value that was reading." arrowPointAtCenter>
            <InfoCircleOutlined />
          </Tooltip>
        </Form.Item>
      </Form>
  )
}
