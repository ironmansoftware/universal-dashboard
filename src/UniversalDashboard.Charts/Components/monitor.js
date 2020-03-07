import React, { useEffect, useState, Fragment } from 'react'
import { Chart, Tooltip, Axis, Legend, Area, Line } from 'viser-react'
import ReactInterval from 'react-interval'
import DataSet from '@antv/data-set'

export default ({ content, fields, ...props }) => {
  const [data, setData] = useState([])
  // const ds = new DataSet()
  // const dv = ds.createView('monitor').source(data)

  const loadData = () =>
    UniversalDashboard.get(
      `/api/internal/component/element/${props.id}`,
      result => {
        if (result.error) console.log(result.error)
        //dv.addRow(result)
        const newData = data.splice(0);
        newData.push(result[0])
        setData(newData)
      },
    )

  useEffect(() => {
    loadData()
  },[])

  const scale = [
    {
      dataKey: `${fields[0]}`,
      type: 'time',
      mask: 'MM:ss',
      nice: false,
    },
    {
      dataKey: `${fields[1]}`,
      min: 0,
      max: 120,
    },
  ]

  //console.log(dv.rows)
  console.log(data)
  return (
    <Fragment>
      <Chart forceFit height={400} data={data} scale={scale}>
        <Tooltip />
        <Axis />
        <Line position={`${fields[0]}*${fields[1]}`} />
        <Area
          position={`${fields[0]}*${fields[1]}`}
          animate={{
            update: {
              duration: 0,
            },
          }}
        />
      </Chart>
      <ReactInterval enabled={true} callback={loadData} timeout={3000} />
    </Fragment>
  )
}
