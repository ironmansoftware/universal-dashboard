import React from 'react'
import Drawer from '@mui/material/Drawer'
import { withComponentFeatures } from 'universal-dashboard'
import makeStyles from '@mui/styles/makeStyles';
var classNames = require('classnames');

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
  list: {
    width: 250,
  },
}))

const UDDrawer = props => {
  const classes = useStyles()

  const onClose = () => {
    props.setState({ open: false })
  }

  return (
    <Drawer {...props} open={props.open} onClose={onClose} key={props.id} id={props.id}>
      <div className={classNames(classes.list, props.className)} role="presentation">
        {props.render(props.children)}
      </div>
    </Drawer>
  )
}

export default withComponentFeatures(UDDrawer)
