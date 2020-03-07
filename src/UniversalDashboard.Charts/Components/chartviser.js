import React from 'react'
import { Chart, Tooltip, Axis, Legend, Bar } from 'viser-react'

export default ({ content, fields, ...props }) => (
  <Chart forceFit height={400} data={JSON.parse(content)}>
    <Tooltip />
    <Axis />
    <Legend />
    <Bar position={`${fields[0]}*${fields[1]}`} color={props.color}/>
  </Chart>
)
