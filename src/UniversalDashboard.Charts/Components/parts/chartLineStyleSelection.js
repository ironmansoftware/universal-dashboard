import React from 'react'
import { useMonitor } from '../api/MonitorState'
import { useThemeUI } from 'theme-ui'
import Icon from '@ant-design/icons'
import Select from 'antd/es/select'
import 'antd/es/select/style'

export default () => {
  const [, dispatch] = useMonitor()
  const context = useThemeUI()
  const { theme, colorMode } = context
  const Option = Select.Option

  const onChartLineTypeChange = value =>
    dispatch({
      type: 'SET_CHART_LINE_TYPE',
      payload: {
        chartLineStyle: value,
      },
    })

  return (
    <Select
      placeholder="Chart line style"
      bordered={false}
      onChange={onChartLineTypeChange}
      style={{ marginRight: 24 }}
      showArrow={false}
      defaultValue="sharp"
    >
      <Option value="sharp">
        <span>
          <SharpIcon style={{ color: theme.chart[colorMode].defaultColor }} />
          <span
            style={{
              marginLeft: 4,
              color: theme.chart[colorMode].title.fill,
            }}
          >
            Sharp Line
          </span>
        </span>
      </Option>
      <Option value="smooth">
        <span>
          <SmoothIcon style={{ color: theme.chart[colorMode].defaultColor }} />
          <span
            style={{
              marginLeft: 4,
              color: theme.chart[colorMode].title.fill,
            }}
          >
            Smooth Line
          </span>
        </span>
      </Option>
    </Select>
  )
}

const Sharp = () => (
  <svg viewBox="0 0 1024 1024" width="1em" height="1em" fill="currentColor">
    <path
      d="M221.342 686.08l-48.837-33.083 215.04-317.44 184.32 239.065L764.849 335.95l45.686 37.021-239.458 296.96-180.382-233.55L221.342 686.08z"
      p-id="1372"
    ></path>
  </svg>
)
const SharpIcon = props => <Icon component={Sharp} {...props} />

const Smooth = () => (
  <svg viewBox="0 0 1024 1024" width="1em" height="1em" fill="currentColor">
    <path
      d="M236.308 620.308a18.51 18.51 0 0 1-6.302 0 29.145 29.145 0 0 1-22.45-35.053c39.386-181.957 143.755-220.16 225.675-220.16 66.166 0 93.341 60.653 115.003 109.096 24.418 53.563 42.535 87.04 81.92 87.04 86.252 0 132.332-85.859 169.354-178.413a29.538 29.538 0 0 1 55.138 22.056c-42.93 106.338-102.794 215.434-224.492 215.434-80.739 0-111.459-68.136-135.877-122.486s-35.84-74.437-61.046-74.437c-88.222 0-143.36 56.713-168.173 173.686a29.145 29.145 0 0 1-28.75 23.237z"
      p-id="1499"
    ></path>
  </svg>
)
const SmoothIcon = props => <Icon component={Smooth} {...props} />
