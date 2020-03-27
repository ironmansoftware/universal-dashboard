import { Chart, Tooltip, Legend, View } from 'viser-react'
import { useMonitor } from './api/MonitorState'
import DataSet from '@antv/data-set'
import React, { useState } from 'react'
import ReactInterval from 'react-interval'
import { useThemeUI } from 'theme-ui'

import Axis from './parts/axis'
import StackArea from './parts/stackArea'
import Line from './parts/lineArea'

import Layout from 'antd/es/layout'
import 'antd/es/layout/style'

const { Content } = Layout

export default ({ height, width, ...props }) => {
  const [currentData, setCurrentData] = useState([])
  const [database, setDatabase] = useState([])
  const dataSet = new DataSet()
  const dataView = dataSet.createView().source(currentData)
  const [state, dispatch] = useMonitor()
  const { settings, running } = state
  const context = useThemeUI()
  const { theme, colorMode } = context

  const loadData = () =>
    UniversalDashboard.get(
      `/api/internal/component/element/${props.id}`,
      result => {
        if (result.error) console.log(result.error)
        const time = new Date().getTime()

        result.map(item =>
          dataView.addRow({
            ...item,
            time: time,
          }),
        )

        let newRes = result.map(item => ({
          ...item,
          time: time,
        }))

        setDatabase(database => database.concat(newRes))
        dispatch({ type: 'LOAD_DATA', payload: database })

        let newData = dataView.rows
        if (newData.length >= 50) {
          newRes.forEach(element => {
            newData.shift()
          })
        }
        setCurrentData(newData)
      },
    )

  const refreshInterval = {
    off: null,
    '5s': 1000 * 5,
    '1m': 1000 * 60,
    '5m': 1000 * 60 * 5,
    '10m': 1000 * 60 * 10,
    '15m': 1000 * 60 * 15,
    '30m': 1000 * 60 * 30,
    '1h': 1000 * 60 * 60,
  }

  return (
    <Content
      style={{
        backgroundColor: 'transparent',
        overflow: 'hidden',
        padding: 48,
      }}
    >
      <Chart
        forceFit
        width={width}
        height={height}
        padding={48}
        data={currentData}
        background={{ fill: 'transparent' }}
      >
        <Axis {...theme.chart[colorMode].axis} />
        <Tooltip />
        <Legend dataKey={props.color} show={true} position="top-left" />
        <View
          scale={[
            {
              dataKey: 'time',
              type: 'time',
              mask: 'HH:mm:ss',
              sync: true
            },
            {
              dataKey: `${props.fields[0]}`,
              min: 0,
              sync: true,
            },
          ]}
        >
          {settings.chartType === 'area' ? (
            <StackArea fields={props.fields} color={props.color} />
          ) : (
            <Line fields={props.fields} color={props.color} />
          )}
        </View>
      </Chart>
      <ReactInterval
        enabled={running}
        timeout={refreshInterval[settings.refreshInterval]}
        callback={loadData}
      />
    </Content>
  )
}
