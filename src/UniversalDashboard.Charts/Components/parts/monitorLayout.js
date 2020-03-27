import React from 'react'
import { useThemeUI } from 'theme-ui'
import Layout from 'antd/es/layout'
import 'antd/es/layout/style'


export default ({ children }) => {
  const context = useThemeUI()
  const { theme, colorMode } = context

  return (
    <Layout
      id="ud-monitor-layout"
      style={{
        backgroundColor: theme.chart[colorMode].background.fill,
      }}
    >
      {children}
    </Layout>
  )
}
