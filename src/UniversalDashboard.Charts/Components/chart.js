import React, { useEffect, useRef } from 'react'

// const Progress = lazy(() => import('@antv/g2plot/esm/sparkline/progress'))
// const RingProgress = lazy(() =>
//   import('@antv/g2plot/esm/sparkline/ring-progress'),
// )
// const TinyArea = lazy(() => import('@antv/g2plot/esm/sparkline/tiny-area'))
// const TinyColumn = lazy(() => import('@antv/g2plot/esm/sparkline/tiny-column'))
// const TinyLine = lazy(() => import('@antv/g2plot/esm/sparkline/tiny-line'))

import { useThemeUI } from 'theme-ui'
import { Card, Typography, Tooltip } from 'antd/es'
// import Icon from '@ant-design/icons-react'

export default ({
  id,
  content,
  // interactions,
  forceFit,
  label,
  legend,
  tooltip,
  title,
  description,
  xField,
  yField,
  chartType,
  ...props
}) => {
  // create self ref to used in g2plot
  const chartRef = useRef(null)

  // using the theme hook from theme-ui module.
  // this theme is used all over the universal dashboard module.
  const context = useThemeUI()
  const { theme } = context

  useEffect(() => {
    if (!chartRef.current) return
    console.log('Chart Type: ', chartType)

    let config = {
      colors: Array.from(theme.chart.colors).entries(([key, value]) => value),
      title: title && { ...title },
      description: description && { ...description },
      tooltip: tooltip && {
        ...tooltip,
        htmlContent: (title, items) =>
          (customTooltip &&
            UniversalDashboard.renderComponent(customTooltip)) ||
          null,
      } || {},
      label: label && { ...label },
      legend: legend && { ...legend },
      padding: 'auto',
      forceFit: forceFit,
      xField: xField,
      xAxis: { visible: true, autoHideLabel: true },
      yField: yField,
      colorField: xField,
      data: JSON.parse(content),
      // interactions: [
      //   {
      //     type: 'slider',
      //     cfg: {
      //       start: 0.1,
      //       end: 0.2,
      //     },
      //   },
      // ],
    }

    
    import('@antv/g2plot/esm/index.js').then((module) => {
      let CType = module[chartType]
       let Chart = new CType(chartRef.current, {...config})
       Chart.render()
    })
    
  }, [])

  return (
    <Card>
      <div id={id} ref={chartRef} />
    </Card>
  )
}
