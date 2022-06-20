import React, { useState } from 'react'
import AppBar from '@mui/material/AppBar'
import Toolbar from '@mui/material/Toolbar'
import { withComponentFeatures } from 'universal-dashboard'
import makeStyles from '@mui/styles/makeStyles';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import ToggleColorModes from './framework/togglecolormodes';
var classNames = require('classnames');


const drawerWidth = 250;

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
  menuButton: {
    marginRight: theme.spacing(2),
  },
  appBar: props => ({
    width: props.drawer && (props.drawer.variant === "permanent" || (props.drawer.variant === "persistent" && props.open)) && `calc(100% - ${drawerWidth}px)`,
    marginLeft: props.drawer && (props.drawer.variant === "permanent" || (props.drawer.variant === "persistent" && props.open)) && drawerWidth,
    top: props.footer ? 'auto' : null,
    bottom: props.footer ? 0 : null
  })
}))

const UDAppBar = props => {
  const [open, setOpen] = useState(false);
  const classes = useStyles({ ...props, open });

  var drawer = null;
  var drawerButton = null;
  if (props.drawer) {
    drawer = props.render(props.drawer);

    const openDrawer = () => {
      let shouldOpen = true;
      if (props.drawer.variant === "persistent" && open) {
        shouldOpen = false;
      }
      setOpen(shouldOpen);
      props.publish(props.drawer.id, {
        type: 'setState',
        state: { open: shouldOpen }
      });
    }

    drawerButton = props.drawer.variant !== 'permanent' && <IconButton
      id={`btn${props.drawer.id}`}
      edge="start"
      className={classes.menuButton}
      color="inherit"
      aria-label="menu"
      onClick={openDrawer}
      size="large">
      <MenuIcon />
    </IconButton>
  }

  return [
    <AppBar position={props.position} key={props.id} id={props.id} className={classNames(classes.appBar, props.className)} color={props.color}>
      <Toolbar>
        {drawerButton}
        {props.render(props.children)}
        {props.footer || props.disableThemeToggle ? <React.Fragment /> : <ToggleColorModes />}
      </Toolbar>
    </AppBar>,
    drawer
  ]
}

export default withComponentFeatures(UDAppBar)
