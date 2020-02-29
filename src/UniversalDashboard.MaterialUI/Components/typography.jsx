/** @jsx jsx */
import React from 'react'
import Typography from '@material-ui/core/Typography'
import { jsx, useThemeUI, Styled, st } from 'theme-ui'
import Box from '@material-ui/core/Box'

const UDMuTypography = ({ id, content, variant, ...props }) => (
  <Typography id={id} variant={variant} component="div">
    <Box
      {...props}
      sx={{
        color: ['primary', 'secondary', 'text'],
        variant: `styles.${variant}`
      }}
    >
      {content}
    </Box>
  </Typography>
)

export default UDMuTypography
