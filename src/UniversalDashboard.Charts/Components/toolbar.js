/** @jsx jsx */
import React, { useContext, useEffect, useState, useRef } from 'react'
import {
  SettingOutlined,
  CloseOutlined,
  AreaChartOutlined,
  LineChartOutlined,
  FormatPainterFilled,
  FormatPainterOutlined,
} from '@ant-design/icons'
import { useMonitor } from './api/MonitorState'
import { Layout, Button, Select, Input } from 'antd'
import { jsx, useThemeUI } from 'theme-ui'
const { Header } = Layout

export default ({ title, ...props }) => {
  const [state, dispatch] = useMonitor()
  const { settings, theme } = state

  const { Option } = Select
  const onRefreshIntervalChange = value =>
    dispatch({ type: 'SET_REFRESH_INTERVAL', payload: value })
  const onTimeRangeChange = value =>
    dispatch({ type: 'SET_TIME_RANGE', payload: value })
  const onChartTypeChange = value =>
    dispatch({
      type: 'SET_CHART_TYPE',
      payload: {
        chartType: value,
        chartTypeSelector:
          value === 'area' ? (
            <span>
              <AreaChartOutlined style={{ color: theme.props.defaultColor }} />{' '}
              Area chart
            </span>
          ) : (
            <span>
              <LineChartOutlined style={{ color: theme.props.defaultColor }} />{' '}
              Line chart
            </span>
          ),
      },
    })
  const setDarkTheme = () =>
    dispatch({ type: 'THEME_CHANGE', payload: { title: 'udDark' } })
  const setLightTheme = () =>
    dispatch({ type: 'THEME_CHANGE', payload: { title: 'udLight' } })
  return (
    <Header
      style={{
        backgroundColor: 'inherit',
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
        <Select
          placeholder="Chart type"
          bordered={false}
          onChange={onChartTypeChange}
          value={settings.chartTypeSelector}
          defaultActiveFirstOption={true}
        >
          <Option value="area">
            <span>
              <AreaChartOutlined style={{ color: theme.props.defaultColor }} />{' '}
              Area chart
            </span>
          </Option>
          <Option value="line">
            <span>
              <LineChartOutlined style={{ color: theme.props.defaultColor }} />{' '}
              Line chart
            </span>
          </Option>
        </Select>
        <Select
          placeholder="Select time range"
          bordered={false}
          onChange={onTimeRangeChange}
          value={`[ ${settings.timeRange} ] Time Range`}
          defaultValue="1h"
        >
          <Option value="5m">5m</Option>
          <Option value="15m">15m</Option>
          <Option value="30m">30m</Option>
          <Option value="1h">1h</Option>
          <Option value="3h">3h</Option>
          <Option value="5h">5h</Option>
        </Select>
        <Select
          placeholder="Select refresh interval"
          bordered={false}
          onChange={onRefreshIntervalChange}
          value={`[ ${settings.refreshInterval} ] Interval`}
          defaultValue="off"
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
      </Input.Group>
      <Input.Group
        style={{
          display: 'flex',
          flex: 1,
          alignItems: 'center',
          justifyContent: 'flex-end',
        }}
      >
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
        />
        <Button
          icon={
            theme.title === 'udLight' ? (
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
            theme.title === 'udLight' ? setDarkTheme() : setLightTheme()
          }
          type="link"
          size="small"
        />
      </Input.Group>
    </Header>
  )
}

export const AreaChartIcon = () => {
  const [state, dispatch] = useMonitor()
  const { theme } = state
  return (
    <span>
      <AreaChartOutlined style={{ color: theme.props.defaultColor }} /> Area
      chart
    </span>
  )
}
