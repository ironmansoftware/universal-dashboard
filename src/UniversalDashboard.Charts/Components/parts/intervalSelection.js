import React from 'react'
import { useMonitor } from '../api/MonitorState'
import { useThemeUI } from 'theme-ui'

import Select from 'antd/es/select'
import 'antd/es/select/style'

export default () => {
  const [{ settings }, dispatch] = useMonitor()
  const context = useThemeUI()
  const { theme, colorMode } = context
  const Option = Select.Option

  const onRefreshIntervalChange = value =>
    dispatch({ type: 'SET_REFRESH_INTERVAL', payload: value })

  const value = (
    <div>
      <span style={{ marginRight: 4, color: theme.chart[colorMode].defaultColor }}>[</span>
      <span style={{ color: theme.chart[colorMode].title.fill }}>
        {' '}
        {settings.refreshInterval}{' '}
      </span>
      <span style={{ marginLeft: 4, color: theme.chart[colorMode].defaultColor }}>]</span>
      <span style={{ marginLeft: 4, color: theme.chart[colorMode].title.fill }}>
        Interval
      </span>
    </div>
  )

  return (
    <Select
      placeholder="Select refresh interval"
      bordered={false}
      onChange={onRefreshIntervalChange}
      value={value}
      showArrow={false}
      style={{ marginRight: 24 }}
    >
      <Option value="off">Off</Option>
      <Option value="5s">5s</Option>
      <Option value="1m">1m</Option>
      <Option value="5m">5m</Option>
      <Option value="10m">10m</Option>
      <Option value="15m">15m</Option>
      <Option value="30m">30m</Option>
      <Option value="1h">1h</Option>
    </Select>
  )
}
