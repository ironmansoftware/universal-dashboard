import React, { useCallback, useEffect, useRef } from 'react'
import { Line, Column } from '@antv/g2plot'
import { useThemeUI } from 'theme-ui'
import {Card} from '@material-ui/core'
export default ({
  id,
  content,
  title,
  description,
  xField,
  yField,
  chartType,
  ...props
}) => {
  const context = useThemeUI()
  const { theme } = context
  const chartRef = useRef(null)

 
  // const chartProps = {
  //   title: {
  //     visible: true,
  //     text: title,
  //     style: {},
  //   },
  //   description: {
  //     visible: true,
  //     text: description,
  //     style: {},
  //   },
  //   width: props.width,
  //   height: props.height,
  //   tooltip: {},
  //   legend: {
  //     position: [
  //       'left-top',
  //       'left-center',
  //       'left-bottom',
  //       'right-top',
  //       'right-center',
  //       'right-bottom',
  //       'top-left',
  //       'top-center',
  //       'top-right',
  //       'bottom-left',
  //       'bottom-center',
  //       'bottom-right',
  //     ],
  //     formatter: value => {
  //       return (<DesktopWindows />), { value }
  //     },
  //   },
  // }
  useEffect(() => {
    if (!chartRef.current) return

    const Chart = new Column(chartRef.current, {
      colors: Array.from(theme.chart.colors).entries(([key, value]) => value),
      title: {
        visible: true,
        text: title,
        // style: props.title.style && props.title.style || theme.chart.title.style
      },
      description: {
        visible: true,
        text: description,
        // style: props.description.style && props.description.style || theme.chart.description.style 
      },
      padding: 'auto',
      forceFit: true,
      xField: xField,
      xAxis: {
        visible: true,
        autoHideLabel: true,
      },
      yField: yField,
      label: {
        visible: false,
      },
      legend: {
        visible: true,
        position: 'top-center',
        marker: 'diamond'
      },
      colorField: xField,
      data: JSON.parse(content),
      interactions: [
        {
          type: 'slider',
          cfg: {
            start: 0.1,
            end: 0.2,
          },
        },
      ],
    })
    Chart.render()
  }, [])

  return <Card><div id={id} ref={chartRef} /></Card>
}
