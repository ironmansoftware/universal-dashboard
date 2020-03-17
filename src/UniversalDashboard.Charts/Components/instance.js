import React, { useRef, useState, useEffect } from 'react'
import { Chart, Tooltip, Axis, Legend, Line, Area, Global } from 'viser-react'
import ReactInterval from 'react-interval'
import { useMonitor } from './api/MonitorState'
import DataSet from '@antv/data-set'

export default ({ height, width, ...props }) => {
  const [data, setData] = useState([])
  const dataSet = new DataSet()
  const dataView = dataSet.createView().source(data)
  const [state, dispatch] = useMonitor()
  const { settings, theme, running } = state

  const loadData = () =>
    UniversalDashboard.get(
      `/api/internal/component/element/${props.id}`,
      result => {
        if (result.error) console.log(result.error)
        const time = new Date().getTime()
        // Cpu data
        result.map(item =>
          dataView.addRow({
            ...item,
            time: time,
          }),
        )

        dispatch({ type: 'LOAD_DATA', payload: dataView.rows })

        let newData = dataView.rows
        if (newData.length >= 100) {
          newData.shift()
          newData.shift()
        }
        setData(newData)
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
      <Line position={`time*${props.fields[0]}`} color={[props.color,theme.props.colors_16]} shape="smooth"/>
      <Area position={`time*${props.fields[0]}`} color={[props.color,theme.props.colors_16]} shape="smooth"/>
    </React.Fragment>
  )

  Global.setTheme(theme)
  return (
    <React.Fragment>
      <Chart forceFit height={400} data={data} scale={scale} padding={48} background={{...theme.props.background}}>
        <Tooltip />
        <Axis />
        <Legend />
        {settings.chartType === 'area' ? (
          area
        ) : (
          <Line position={`time*${props.fields[0]}`} color={[props.color,theme.props.colors_16]} shape="smooth"/>
        )}
      </Chart>
      <ReactInterval
        enabled={running}
        timeout={refreshInterval[settings.refreshInterval]}
        callback={loadData}
      />
    </React.Fragment>
  )
}
