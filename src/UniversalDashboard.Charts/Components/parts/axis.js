import React from 'react'
import { Axis } from 'viser-react'
// import { useMonitor } from '../api/MonitorState'

export default ({ style }) => {  
    return <Axis label={{ ...style }} />
}