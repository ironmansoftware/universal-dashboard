/** @jsx jsx */
import React from 'react';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Link from '@material-ui/core/Link';
import { makeStyles } from '@material-ui/core/styles';
import {jsx} from 'theme-ui'

const useStyles = makeStyles(theme => ({
    appBar: {
      top: 'auto',
      bottom: 0,
    }
  }));
  

const UDFooter = (props) => {
    const classes = useStyles();

    return (
        <AppBar position="sticky" className={classes.appBar} sx={{bg: 'primary', color: 'text'}}>
            <Toolbar><Link color="inherit" href="http://www.poshud.com">Created with PowerShell Universal Dashboard</Link></Toolbar>
        </AppBar>
    )
}

export default UDFooter;