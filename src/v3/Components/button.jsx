/** @jsx jsx */
import React from 'react'
import classNames from 'classnames'
import Button from '@material-ui/core/Button'
import UdMuIcon from './icon'
import { withComponentFeatures } from './universal-dashboard'
import { makeStyles } from '@material-ui/core/styles'
import { jsx } from 'theme-ui'

const useStyles = makeStyles(theme => ({
  button: {
    margin: theme.spacing.unit,
  },
  leftIcon: {
    marginRight: theme.spacing.unit,
  },
  rightIcon: {
    marginLeft: theme.spacing.unit,
  },
}))

const UdButton = props => {
  const classes = useStyles()

  const handleClick = () => {
    if (props.onClick == null) return
    props.onClick();
  }

  var icon = props.icon ? (
    <UdMuIcon
      {...props.icon}
      style={
        props.iconAlignment === 'left' ? { marginRight: 8 } : { marginLeft: 8 }
      }
    />
  ) : null

  return (
    <Button
      variant={props.variant}
      size={props.size}
      disabled={props.disabled}
      className={classNames(classes.button, 'ud-mu-button')}
      fullWidth={props.fullWidth}
      href={props.href}
      onClick={handleClick}
      style={{ ...props.style }}
      //sx={{ bg: 'primary', color: 'text' }}
      id={props.id}
    >
      {props.iconAlignment === 'left' ? icon : null}
      {props.text}
      {props.iconAlignment === 'right' ? icon : null}
    </Button>
  )
}

export default withComponentFeatures(UdButton)
