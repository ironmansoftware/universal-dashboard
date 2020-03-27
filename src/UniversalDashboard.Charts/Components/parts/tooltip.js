import React from 'react'
import Tooltip from 'antd/es/tooltip'
import 'antd/es/tooltip/style'

export default ({ title, children, ...props }) => (
  <Tooltip title={title} {...props}>
    {children}
  </Tooltip>
)