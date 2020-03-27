import React from 'react'
import { useThemeUI } from 'theme-ui'

export default ({ title }) => {
  const context = useThemeUI()
  const { theme, colorMode } = context
  return <h3 style={{ ...theme.chart[colorMode].title }}>{title}</h3>
}
