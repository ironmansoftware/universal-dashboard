import React from 'react'
import { useMonitor } from '../api/MonitorState'
import { AreaChartOutlined, LineChartOutlined } from '@ant-design/icons'
import { Select } from 'antd/es'

export default () => {
  const [{ theme }, dispatch] = useMonitor()
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
          <AreaChartOutlined style={{ color: theme.props.defaultColor }} /> 
          <span style={{ marginLeft: 4, color: theme.props.axis.bottom.label.textStyle.fill }}>Area chart</span>
        </span>
      </Option>
      <Option value="line">
        <span>
          <LineChartOutlined style={{ color: theme.props.defaultColor }} /> 
          <span style={{ marginLeft: 4, color: theme.props.axis.bottom.label.textStyle.fill }}>Line chart</span>
        </span>
      </Option>
    </Select>
  )
}
