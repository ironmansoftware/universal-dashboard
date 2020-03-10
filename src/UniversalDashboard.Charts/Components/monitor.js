import React, { useEffect, useState, Fragment } from 'react'
import {
  Chart,
  Tooltip,
  Axis,
  Legend,
  Brush,
  Global,
  StackArea,
  Slider,
  Plugin
} from 'viser-react'
import ReactInterval from 'react-interval'
import DataSet from '@antv/data-set'
import theme from './theme/viserTheme'

export default ({ content, fields, ...props }) => {
  const [cpuData, setCpuData] = useState([])
  const dataSet = new DataSet()
  const cpuView = dataSet.createView().source(cpuData)

  Global.setTheme(theme)

  const loadData = () =>
    UniversalDashboard.get(
      `/api/internal/component/element/${props.id}`,
      result => {
        if (result.error) console.log(result.error)
        const time = new Date().getTime()
        // Cpu data
        cpuView.addRow({
          ...result[0],
          time: time,
        })
        let newCpuData = cpuView.rows
        if (newCpuData.length >= 20) newCpuData.shift()
        setCpuData(newCpuData)
      },
    )

  const scale = [
    {
      dataKey: 'time',
      type: 'time',
      mask: 'HH:mm:ss',
      sync: true,
    },
    {
      dataKey: `${fields[0]}`,
      min: 0,
      sync: true,
    },
  ]

  return (
    <Fragment>
      <Chart forceFit height={400} data={cpuData} scale={scale} padding={48}>
        <Tooltip />
        <Axis />
        <Legend />
        <StackArea position={`time*${fields[0]}`} color={props.color} />
        <Brush
          canvas={null}
          style={{
            fill: '#ccc',
            fillOpacity: 0.4,
          }}
        />
      </Chart>
      <ReactInterval enabled={true} timeout={1000} callback={loadData} />
      <Plugin>
        <Slider
          container="viser-slider-1"
          width="auto"
          height={26}
          start={cpuView.rows[0].time}
          end={cpuView.rows[-1].time}
          xAxis="time"
          yAxis={`${fields[0]}`}
          scales={{
            time: {
              type: 'time',
              tickCount: 10,
              mask: 'DD/M HH:mm',
            },
          }}
          data={cpuView.rows}
          backgroundChart={{
            type: 'line',
          }}
          
        />
      </Plugin>
    </Fragment>
  )
}
