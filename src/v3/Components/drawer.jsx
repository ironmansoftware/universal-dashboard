import React from 'react'
import Drawer from '@material-ui/core/Drawer'
import { withComponentFeatures } from './universal-dashboard'
import { makeStyles } from '@material-ui/core/styles'

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
  list: {
    width: 250,
  },
}))

const UDDrawer = props => {
    const classes = useStyles()

    const onClose = () => {
        props.setState({open: false})
    }

    return (
        <Drawer open={props.open} onClose={onClose} key={props.id} id={props.id}>
          <div className={classes.list} role="presentation">
            {props.render(props.children)}
          </div>
        </Drawer>
    )
}

export default withComponentFeatures(UDDrawer)
