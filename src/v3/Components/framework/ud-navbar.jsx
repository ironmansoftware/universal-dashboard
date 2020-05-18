/** @jsx jsx */
import React, {useState, useEffect} from 'react';
import { makeStyles } from '@material-ui/core/styles';
import ToggleColorMode from './togglecolormodes'
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from '@material-ui/icons/Menu';

import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemIcon from '@material-ui/core/ListItemIcon';
import ListItemText from '@material-ui/core/ListItemText';

import Drawer from '@material-ui/core/Drawer';
import {jsx} from 'theme-ui'

import { withComponentFeatures } from './../universal-dashboard'

const useStyles = makeStyles({
    list: {
      width: 250,
    },
    fullList: {
      width: 'auto',
    },
  });

const UdNavbar = (props) => {
    const classes = useStyles();

    const [open, setOpen] = useState(false);

    const onItemClick = (page) => {
        props.history.push(`/${page.name.replace(/ /g, "-")}`);    
        setOpen(false);
    }
    
    const renderSideNavItem = (item) => {
        var linkText = item.text ? item.text : item.name;
    
        return <ListItem button onClick={() => onItemClick(item)}>
            <ListItemText>{linkText}</ListItemText>
        </ListItem>
    }

    var menuButton = null;
    var drawer = null; 

    if (props.pages.length > 1)
    {
        var links = props.pages.map(function(x, i) {
            if (x.name == null) return null;
            return renderSideNavItem({...x, history: props.history, setOpen: props.setOpen});
        })
    
        drawer = <Drawer open={open} onClose={() => setOpen(false)}>
            <div className={classes.list} role="presentation">
                <List>
                    {links}
                </List> 
            </div>
        </Drawer>

        menuButton = <IconButton edge="start" color="inherit" aria-label="menu" onClick={() => setOpen(true)} >
            <MenuIcon />
        </IconButton>
    }

    var children = null;
    if (props.children)
    {
        children = props.render(props.children);
    }

    return [
        drawer,
        <AppBar position="static" sx={{bg: 'primary', color: 'text'}}>
            <Toolbar>
                {menuButton}
                <Typography variant="h6">
                    {props.title}
                </Typography>
                <ToggleColorMode />
                {children}
            </Toolbar>
        </AppBar>
    ]
}

export default withComponentFeatures(UdNavbar);