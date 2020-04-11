/** @jsx jsx */
import React from 'react'
import PropTypes from 'prop-types'
import { withStyles } from '@material-ui/core/styles'
import Avatar from '@material-ui/core/Avatar'
import classNames from 'classnames'
import { jsx } from 'theme-ui'

function UDMuAvatar(props) {
  const { classes } = props

  return (
    <Avatar
      id={props.id}
      alt={props.alt}
      src={props.image}
      className={classNames(props.className, 'ud-mu-avatar')}
      sx={{ variant: `avatars.${props.variant}` }}
    />
  )
}

export default UDMuAvatar
