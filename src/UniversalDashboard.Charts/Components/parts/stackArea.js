import React from 'react'
import { StackArea } from 'viser-react'
import { useThemeUI } from 'theme-ui'
import { useMonitor } from '../api/MonitorState'

export default ({ color, fields }) => {
  const [{ settings }] = useMonitor()
  const context = useThemeUI()
  const { theme, colorMode } = context

  return (
    <StackArea
      position={`time*${fields[0]}`}
      color={[color, theme.chart[colorMode].colors]}
      shape={settings.chartLineStyle === 'sharp' ? null : 'smooth'}
    />
  )
}
