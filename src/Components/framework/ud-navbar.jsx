import React, { useState, useEffect } from 'react';
import makeStyles from '@mui/styles/makeStyles';
import AppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import AccountCircle from '@mui/icons-material/AccountCircle';
import MenuItem from '@mui/material/MenuItem';
import Menu from '@mui/material/Menu';


import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';

import Drawer from '@mui/material/Drawer';

import { withComponentFeatures } from 'universal-dashboard'
import ToggleColorMode from './togglecolormodes.jsx';

const drawerWidth = 250;

const useStyles = makeStyles((theme) => ({
    list: {
        width: drawerWidth,
    },
    fullList: {
        width: 'auto',
    },
    drawer: {
        width: drawerWidth,
        flexShrink: 0,
    },
    grow: {
        flexGrow: 1,
    },
    drawerPaper: {
        width: drawerWidth
    },
    drawerContainer: {
        overflow: 'auto',
    },
    fixedAppBar: {
        zIndex: theme.zIndex.drawer + 1,
    },
}));

const UdNavbar = (props) => {
    const classes = useStyles();

    const [open, setOpen] = useState(false);
    const [anchorEl, setAnchorEl] = React.useState(null);
    const menuOpen = Boolean(anchorEl);

    const handleMenu = (event) => {
        setAnchorEl(event.currentTarget);
    };

    const handleClose = () => {
        setAnchorEl(null);
    };

    const onItemClick = (page) => {
        if (page.url) {
            var url = page.url;
            if (!url.startsWith("/")) {
                url = "/" + url;
            }
            props.history.push(`${url.replace(/ /g, "-")}`);
        }
        else {
            props.history.push(`/${page.name.replace(/ /g, "-")}`);
        }
        setOpen(false);
    }

    const renderSideNavItem = (item) => {
        var linkText = item.text ? item.text : item.name;

        var icon;
        if (item.icon) {
            icon = UniversalDashboard.renderComponent(item.icon);
        }

        return <ListItem button onClick={() => onItemClick(item)}>
            <ListItemText>{icon}{linkText}</ListItemText>
        </ListItem>
    }

    var menuButton = null;
    var drawer = null;

    if (props.pages.length > 1 && !props.navigation && !props.hideNavigation) {
        var links = props.pages.filter(x => x.url.indexOf(":") === -1).map(function (x, i) {
            if (x.name == null) return null;
            return renderSideNavItem({ ...x, history: props.history, setOpen: props.setOpen });
        })

        drawer = <Drawer
            open={open}
            onClose={() => setOpen(false)}
            variant={props.fixed ? "permanent" : "temporary"}
            className={classes.drawer}
            classes={{ paper: classes.drawerPaper }}>
            {props.fixed ? <Toolbar /> : <React.Fragment />}
            <div className={classes.drawerContainer} role="presentation">
                <List>
                    {links}
                </List>
            </div>
        </Drawer>

        menuButton = props.fixed ? <React.Fragment /> : <IconButton
            edge="start"
            color="inherit"
            aria-label="menu"
            onClick={() => setOpen(true)}
            size="large">
            <MenuIcon />
        </IconButton>
    }

    if (props.navigation && !props.hideNavigation) {
        drawer = <Drawer
            open={open}
            onClose={() => setOpen(false)}
            variant={props.fixed ? "permanent" : "temporary"}
            className={classes.drawer}
            classes={{ paper: classes.drawerPaper }}>
            {props.fixed ? <Toolbar /> : <React.Fragment />}
            <div className={classes.drawerContainer} role="presentation">
                <List>
                    {props.render(props.navigation)}
                </List>
            </div>
        </Drawer>

        menuButton = props.fixed ? <React.Fragment /> : <IconButton
            edge="start"
            color="inherit"
            aria-label="menu"
            onClick={() => setOpen(true)}
            size="large">
            <MenuIcon />
        </IconButton>
    }

    var children = null;
    if (props.children) {
        children = props.render(props.children);
    }

    const logout = () => {
        UniversalDashboard.get('/api/v1/signout', () => {
            window.location.href = '/login?ReturnUrl=' + window.location.pathname
        });
    };

    return [
        <AppBar position={props.fixed ? "fixed" : props.position} className={props.fixed ? classes.fixedAppBar : ""} style={{
            color: props.color,
            backgroundColor: props.backgroundColor
        }}>
            <Toolbar>
                {menuButton}
                {props.logo && <img src={props.logo} id="ud-logo" style={{ paddingRight: '10px' }} />}
                <Typography variant="h6">
                    {props.title}
                </Typography>
                <div className={classes.grow} />
                {children}
                {props.disableThemeToggle ? <React.Fragment /> : <ToggleColorMode />}
                {props.windowsAuth && <Typography variant="h6" style={{ paddingLeft: "10px" }}>{props.user}</Typography>}
                {!props.windowsAuth && props.user && props.user !== '' && (<>
                    <IconButton
                        aria-label="account of current user"
                        aria-controls="menu-appbar"
                        aria-haspopup="true"
                        onClick={handleMenu}
                        color="inherit"
                        size="large">
                        <AccountCircle />
                        <Typography variant="h6" style={{ paddingLeft: "10px" }}>{props.user}</Typography>
                    </IconButton>
                    <Menu
                        id="menu-appbar"
                        anchorEl={anchorEl}
                        anchorOrigin={{
                            vertical: 'top',
                            horizontal: 'right',
                        }}
                        keepMounted
                        transformOrigin={{
                            vertical: 'top',
                            horizontal: 'right',
                        }}
                        open={menuOpen}
                        onClose={handleClose}
                    >
                        <MenuItem onClick={logout}>Logout</MenuItem>
                    </Menu>
                </>)}
            </Toolbar>
        </AppBar>,
        drawer
    ];
}

export default withComponentFeatures(UdNavbar);