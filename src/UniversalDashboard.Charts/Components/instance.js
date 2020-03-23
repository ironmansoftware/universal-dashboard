import { Chart, Tooltip, Legend, StackLine, Line, StackArea, Global, View } from 'viser-react'
import { Layout } from 'antd/es'
import { useMonitor } from './api/MonitorState'
import DataSet from '@antv/data-set'
import React, { useRef, useState, useEffect } from 'react'
import ReactInterval from 'react-interval'
import Axis from './parts/axis'
import { useAutoRefresh } from './utils'
const { Content } = Layout

export default ({ height, width, ...props }) => {
  const [currentData, setCurrentData] = useState([])
  const [database, setDatabase] = useState([])
  const dataSet = new DataSet()
  const dataView = dataSet.createView().source(currentData)
  const [state, dispatch] = useMonitor()
  const { settings, theme, running, data } = state

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

        let newRes = result.map(item =>({
            ...item,
            time: time,
          })
        )
        setDatabase(database => database.concat(newRes))
        dispatch({ type: 'LOAD_DATA', payload: database })

        let newData = dataView.rows
        if (newData.length >= 50) {
          newData.shift()
          newData.shift()
        }
        setCurrentData(newData)
      },
    )

    // useAutoRefresh(loadData)
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

  const scale = [
    {
      dataKey: 'time',
      type: 'time',
      mask: 'HH:mm:ss',
      sync: true,
    },
    {
      dataKey: `${props.fields[0]}`,
      min: 0,
      sync: true,
    },
  ]

  const area = (
    <React.Fragment>
      <StackLine
        position={`time*${props.fields[0]}`}
        color={[props.color, theme.props.colors]}
        shape="smooth"
      />
      <StackArea
        position={`time*${props.fields[0]}`}
        color={[props.color, theme.props.colors]}
        shape="smooth"
      />
    </React.Fragment>
  )

  return (
    <Content
      style={{
        backgroundColor: theme.props.background.fill,
        overflow: 'hidden',
        padding: 48,
      }}
    >
      <div style={{ backgroundColor: theme.props.background.fill }}>
        <Chart
          forceFit
          height={400}
          
          padding={48}
          background={{ fill: 'transparent' }}
        >
          <Tooltip />
          <Legend />
          <Axis style={{...theme.props.axis.label }}/>
          <View data={currentData} scale={scale}>
          {settings.chartType === 'area' ? (
            area
          ) : (
            <Line
              position={`time*${props.fields[0]}`}
              color={[props.color, theme.props.colors]}
              shape="smooth"
            />
          )}
          </View>
        </Chart>
        <ReactInterval
          enabled={running}
          timeout={refreshInterval[settings.refreshInterval]}
          callback={loadData}
        />
      </div>
    </Content>
  )
}
