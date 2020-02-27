/** @jsx jsx */
import React from 'react'
import Drawer from '@material-ui/core/Drawer'
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

const UDDrawer = props => {
    const classes = useStyles()

    const onClose = () => {
        props.setState({open: false})
    }

    return (
        <Drawer open={props.open} onClose={onClose}>
            {props.render(props.children)}
        </Drawer>
    )
}

export default withComponentFeatures(UDDrawer)
