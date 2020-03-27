import React from 'react'
import { useThemeUI } from 'theme-ui'

export default ({ description }) => {
  const context = useThemeUI()
  const { theme, colorMode } = context
  return (
    <h6
      style={{ ...theme.chart[colorMode].description }}
    >
      {description}
    </h6>
  )
}
