import React, {useState} from 'react'
import AppBar from '@material-ui/core/AppBar'
import Toolbar from '@material-ui/core/Toolbar'
import { withComponentFeatures } from './universal-dashboard'
import { makeStyles } from '@material-ui/core/styles'
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from '@material-ui/icons/Menu';
import ToggleColorModes from './framework/togglecolormodes';

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
  menuButton: {
    marginRight: theme.spacing(2),
  },
}))

const UDAppBar = props => {
  const classes = useStyles();

  var drawer = null;
  var drawerButton = null;
  if (props.drawer)
  {
    drawer = props.render(props.drawer);

    const openDrawer = () => {
      props.publish(props.drawer.id, {
        type: 'setState',
        state: { open: true }
      });
    }

    drawerButton = <IconButton id={`btn${props.drawer.id}`} edge="start" className={classes.menuButton} color="inherit" aria-label="menu" onClick={openDrawer}>
        <MenuIcon />
    </IconButton>
  }

  return [
    <AppBar position={props.position} key={props.id} id={props.id}>
        <Toolbar>
            {drawerButton}
            {props.render(props.children)}
            <ToggleColorModes />
        </Toolbar>
    </AppBar>,
    drawer
  ]
}

export default withComponentFeatures(UDAppBar)
