import React from 'react'
import { useMonitor } from '../api/MonitorState'
import { useThemeUI } from 'theme-ui'
import { AreaChartOutlined, LineChartOutlined } from '@ant-design/icons'

import Select from 'antd/es/select'
import 'antd/es/select/style'

export default () => {
  const [, dispatch] = useMonitor()
  const context = useThemeUI()
  const { theme, colorMode} = context
  const Option = Select.Option

  const onChartTypeChange = value =>
    dispatch({
      type: 'SET_CHART_TYPE',
      payload: {
        chartType: value,
      },
    })

  return (
    <Select
      placeholder="Chart type"
      bordered={false}
      onChange={onChartTypeChange}
      style={{ marginRight: 24 }}
      showArrow={false}
      defaultValue="area"
    >
      <Option value="area">
        <span>
          <AreaChartOutlined style={{ color: theme.chart[colorMode].defaultColor }} /> 
          <span style={{ marginLeft: 4, color: theme.chart[colorMode].title.fill }}>Area chart</span>
        </span>
      </Option>
      <Option value="line">
        <span>
          <LineChartOutlined style={{ color: theme.chart[colorMode].defaultColor }} /> 
          <span style={{ marginLeft: 4,  color: theme.chart[colorMode].title.fill }}>Line chart</span>
        </span>
      </Option>
    </Select>
  )
}
