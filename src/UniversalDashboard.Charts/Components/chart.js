import React, { useEffect, useRef, useState } from 'react'
import { useThemeUI } from 'theme-ui'
import * as G2Plot from '@antv/g2plot'
import {
  getGlobalTheme,
  registerGlobalTheme,
} from '@antv/g2plot/esm/theme/global'
import { Select, Card } from 'antd'
import 'antd/es/card/style'
import 'antd/es/select/style'  

export default ({ id, content, chartType, ...props }) => {
  const [cType, setCType] = useState(chartType)

  const container = useRef(null)
  const context = useThemeUI()
  const { theme } = context

  const data = JSON.parse(content)

  useEffect(() => {
    if (!container.current) return

    registerGlobalTheme('udcharts', {
      ...theme.chart,
    })

    let config = {
      ...props,
      theme: 'udcharts',
    }

   
    console.log(getGlobalTheme('udcharts'))

    const Chart = G2Plot[cType]
    const chart = new Chart(container.current, { data, ...config })
    chart.render()
  }, [cType])

   const onChange = value => setCType(value)

    const extra = (
      <Select onChange={onChange} style={{ width: 120 }} >
        {[
          'Line',
          'Bar',
          'Column',
          'Area',
          'Pie',
          'Ring',
          'StackBar',
          'PercentageStackBar',
          'GroupBar',
          'RangeBar',
          'StackColumn',
          'PercentageStackColumn',
          'GroupColumn',
          'Histogram',
          'Waterfall',
          'RangeColumn',
          'StackArea',
          'PercentageStackArea',
          'StepLine',
          'Scatter',
          'Bubble',
          'Radar',
          'Heatmap',
          'Matrix',
          'Funnel',
          'Treemap',
          'Liquid',
          'Gauge',
          'OverlappedComboPlot',
          'Bullet',
          'TinyArea',
          'TinyLine',
          'TinyColumn',
          'RingProgress',
          'Progress',
          'WordCloud',
        ].map(name => (
          <Select.Option key={name} value={name}>{name}</Select.Option>
        ))}
      </Select>
    )
  return (
    <Card extra={extra} style={{width: 450}}>
      <div id={id} ref={container} />
    </Card>
  )
}
