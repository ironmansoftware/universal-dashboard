import React from 'react'
import { SettingOutlined, CloseOutlined } from '@ant-design/icons'
import { useMonitor } from '../api/MonitorState'
import ChartSelection from './chartSelection'
import ChartLineSelection from './chartLineStyleSelection'
import IntervalSelection from './intervalSelection'
import RangeSelection from './rangeSelection'
// import ThemeToggle from './themeToggle'
import { useThemeUI } from 'theme-ui'

import Layout from 'antd/es/layout'
import 'antd/es/layout/style'
import Button from 'antd/es/button'
import 'antd/es/button/style'
import Input from 'antd/es/input'
import 'antd/es/input/style'

const { Header } = Layout

export default () => {
  const [{ settings }, dispatch] = useMonitor()
  const context = useThemeUI()
  const { theme, colorMode } = context

  return (
    <Header
      style={{
        backgroundColor: theme.chart[colorMode].background.fill,
        height: 32,
        lineHeight: 32,
        borderBottom: '2px solid rgba(0, 0, 0, 0.08)',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
      }}
    >
      <Input.Group
        style={{
          display: 'flex',
          flex: 1,
          alignItems: 'center',
          justifyContent: 'flex-start',
        }}
      >
        <ChartSelection />
        <ChartLineSelection />
        <RangeSelection />
        <IntervalSelection />
      </Input.Group>
      <Input.Group
        style={{
          display: 'flex',
          flex: 1,
          alignItems: 'center',
          justifyContent: 'flex-end',
        }}
      >
        {/* <ThemeToggle /> */}
        <Button
          icon={
            !settings.visible ? (
              <SettingOutlined
                style={{ color: theme.chart[colorMode].defaultColor }}
              />
            ) : (
              <CloseOutlined
                style={{ color: theme.chart[colorMode].defaultColor }}
              />
            )
          }
          className="trigger"
          onClick={() =>
            dispatch({
              type: 'SET_SETTINGS_VISIBILITY',
              payload: !settings.visible,
            })
          }
          type="link"
          size="small"
          style={{ marginRight: 24 }}
        />
      </Input.Group>
    </Header>
  )
}
