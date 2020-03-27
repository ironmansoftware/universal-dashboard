import React from 'react'
import UDTooltip from './tooltip'
import { FormatPainterOutlined, FormatPainterFilled } from '@ant-design/icons'
import { useMonitor } from '../api/MonitorState'
import Button from 'antd/es/button'
import 'antd/es/button/style'

export default () => {
  const [{ theme }, dispatch] = useMonitor()
  const setDarkTheme = () =>
    dispatch({ type: 'THEME_CHANGE', payload: { title: 'dark' } })
  const setLightTheme = () =>
    dispatch({ type: 'THEME_CHANGE', payload: { title: 'light' } })

  return (
    <UDTooltip
      title="Change monitor theme"
      style={{ marginRight: 24 }}
      arrowPointAtCenter
    >
      <Button
        icon={
          theme.title === 'light' ? (
            <FormatPainterOutlined
              style={{ color: theme.props.defaultColor }}
            />
          ) : (
            <FormatPainterFilled style={{ color: theme.props.defaultColor }} />
          )
        }
        onClick={() =>
          theme.title === 'light' ? setDarkTheme() : setLightTheme()
        }
        type="link"
        size="small"
      />
    </UDTooltip>
  )
}
