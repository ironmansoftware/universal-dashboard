import React, { useContext, useEffect, useState, useRef } from 'react'
import {
  SettingOutlined,
  CloseOutlined,
  AreaChartOutlined,
  LineChartOutlined,
  FormatPainterFilled,
  FormatPainterOutlined,
} from '@ant-design/icons'
import { useMonitor } from '../api/MonitorState'
import { Layout, Button, Select, Input, Tooltip } from 'antd'
import ChartSelection from './chartSelection'
import IntervalSelection from './intervalSelection'
import RangeSelection from './rangeSelection'

const { Header } = Layout

export default ({ title, ...props }) => {
  const [{ settings, theme }, dispatch] = useMonitor()

  const { Option } = Select



  const setDarkTheme = () =>
    dispatch({ type: 'THEME_CHANGE', payload: { title: 'dark' } })
  const setLightTheme = () =>
    dispatch({ type: 'THEME_CHANGE', payload: { title: 'light' } })
  return (
    <Header
      style={{
        backgroundColor: theme.props.background.fill,
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
        <Tooltip
          title="Change monitor theme"
          style={{ marginRight: 24 }}
          arrowPointAtCenter
        >
          <Button
            icon={
              theme.title === 'light' ? (
                <FormatPainterOutlined
                  style={{ color: theme.props.defaultColor }}
                />
              ) : (
                <FormatPainterFilled
                  style={{ color: theme.props.defaultColor }}
                />
              )
            }
            onClick={() =>
              theme.title === 'light' ? setDarkTheme() : setLightTheme()
            }
            type="link"
            size="small"
          />
        </Tooltip>
        <Button
          icon={
            !settings.visible ? (
              <SettingOutlined style={{ color: theme.props.defaultColor }} />
            ) : (
              <CloseOutlined style={{ color: theme.props.defaultColor }} />
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
