import React from 'react'
import classNames from 'classnames'
import Button from '@mui/material/Button'
import UdMuIcon from './icon'
import { withComponentFeatures } from 'universal-dashboard'
import makeStyles from '@mui/styles/makeStyles';

const useStyles = makeStyles(theme => ({
  button: {
    margin: theme.spacing(),
  },
  leftIcon: {
    marginRight: theme.spacing(),
  },
  rightIcon: {
    marginLeft: theme.spacing(),
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
        props.text ? props.iconAlignment === 'left' ? { ...props.icon.style, marginRight: 8 } : { ...props.icon.style, marginLeft: 8 } : props.icon.style
      }
    />
  ) : null

  return (
    <Button
      variant={props.variant}
      size={props.size}
      disabled={props.disabled}
      className={classNames(classes.button, 'ud-mu-button', props.className)}
      fullWidth={props.fullWidth}
      href={props.href}
      onClick={handleClick}
      style={{ ...props.style }}
      sx={{ bg: 'primary', color: 'text' }}
      id={props.id}
      color={props.color}
    >
      {props.iconAlignment === 'left' ? icon : null}
      {props.text}
      {props.iconAlignment === 'right' ? icon : null}
    </Button>
  )
}

export default withComponentFeatures(UdButton)
