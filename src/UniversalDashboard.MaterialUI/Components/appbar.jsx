/** @jsx jsx */
import React, {useState} from 'react'
import AppBar from '@material-ui/core/AppBar'
import Toolbar from '@material-ui/core/Toolbar'
import { withComponentFeatures } from './universal-dashboard'
import { makeStyles } from '@material-ui/core/styles'
import { jsx } from 'theme-ui'
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from '@material-ui/icons/Menu';

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

  const [drawerOpen, setDrawerOpen] = useState(false);

  var drawer = null;
  var drawerButton = null;
  if (props.drawer)
  {
    const drawerProps = {...props.drawer, open: drawerOpen};
    drawer = props.render(drawerProps);

    drawerButton = <IconButton edge="start" className={classes.menuButton} color="inherit" aria-label="menu" onClick={() => setDrawerOpen(true)}>
        <MenuIcon />
    </IconButton>
  }

  return [
    <AppBar position={props.position}>
        <Toolbar>
            {drawerButton}
            {props.render(props.children)}
        </Toolbar>
    </AppBar>,
    drawer
  ]
}

export default withComponentFeatures(UDAppBar)
