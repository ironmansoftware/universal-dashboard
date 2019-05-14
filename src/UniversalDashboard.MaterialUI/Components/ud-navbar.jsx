import React from 'react';
import { AppBar, Toolbar, Typography, IconButton, Drawer, Divider, List, ListItem, ListItemIcon, ListItemText, Collapse } from '@material-ui/core';
import { withStyles } from '@material-ui/styles';
import MenuIcon from '@material-ui/icons/Menu';
import ChevronLeftIcon from '@material-ui/icons/ChevronLeft';
import ExpandMore from '@material-ui/icons/ExpandMore';
import ExpandLess from '@material-ui/icons/ExpandLess';
import classNames from "classnames"

const drawerWidth = 240;

function getStyles(theme) {
  return {

    // Permanent
    rootFixed: {
      display: 'flex',
    },
    appBarFixed: {
      width: props => `calc(100% - ${props.navigation.width}px)`,
      marginLeft: props => props.navigation.width,
    },
    drawerFixed: {
      width: props => props.navigation.width,
      flexShrink: 0,
    },
    drawerPaperFixed: {
      width: props => props.navigation.width,
    },
    toolbarFixed: theme.mixins.toolbar,
    contentFixed: {
      flexGrow: 1,
      backgroundColor: theme.palette.background.default,
      padding: theme.spacing.unit * 3,
    },

    // Persistent

    root: {
      display: 'flex',
    },
    appBar: {
      transition: theme.transitions.create(['margin', 'width'], {
        easing: theme.transitions.easing.sharp,
        duration: theme.transitions.duration.leavingScreen,
      }),
    },
    appBarShift: {
      width: `calc(100% - ${drawerWidth}px)`,
      marginLeft: drawerWidth,
      transition: theme.transitions.create(['margin', 'width'], {
        easing: theme.transitions.easing.easeOut,
        duration: theme.transitions.duration.enteringScreen,
      }),
    },
    menuButton: {
      marginLeft: 12,
      marginRight: 20,
    },
    hide: {
      display: 'none',
    },
    drawer: {
      width: drawerWidth,
      flexShrink: 0,
    },
    drawerPaper: {
      width: drawerWidth,
    },
    drawerHeader: {
      display: 'flex',
      alignItems: 'center',
      padding: '0 8px',
      ...theme.mixins.toolbar,
      justifyContent: 'flex-end',
    },
    content: {
      flexGrow: 1,
      padding: theme.spacing.unit * 3,
      transition: theme.transitions.create('margin', {
        easing: theme.transitions.easing.sharp,
        duration: theme.transitions.duration.leavingScreen,
      }),
      marginLeft: -drawerWidth,
    },
    contentShift: {
      transition: theme.transitions.create('margin', {
        easing: theme.transitions.easing.easeOut,
        duration: theme.transitions.duration.enteringScreen,
      }),
      marginLeft: 0,
    },
  }
}

const styles = getStyles;

class UdNavbar extends React.Component {

    constructor(props) {
      super(props);

      this.state = {
          paused: false,
          content: props.navigation ? props.navigation.content : null,
          open: props.navigation && props.navigation.fixed,
          customNavigation: props.navigation
      }
    }

    componentWillMount() {
        if (this.state.customNavigation && this.props.content === null) {
            UniversalDashboard.get(`/api/internal/component/element/${this.props.id}`, function(data) {
                this.setState({
                    content: data
                })
            }.bind(this));
        }
    }

    onTogglePauseCycling() {
        this.props.togglePaused();
        this.setState({
            paused: !this.state.paused
        })
    }

    renderSideNavItem(item) {
        return <NavSideItem {...item} history={this.props.history}/>
    }

    signOut() {
        UniversalDashboard.get("/api/internal/signout", function() {
            this.props.history.push("/login");
        }.bind(this));
    }

    homePage() {
        return this.props.pages.find(function(page){
            return page.defaultHomePage === true;
        });
    }

    handleDrawerOpen = () => {
        this.setState({ open: true });
    };

    handleDrawerClose = () => {
        this.setState({ open: false });
    };

    renderDefaultNavigation() {
      if (!this.props.pages || this.props.pages.length === 1) return <div/>;

      var links = this.props.pages.map(function(x, i) {

          if (x.name == null) return null;

          return this.renderSideNavItem(x);
      }.bind(this))

      var pauseToggle = null;
      if (this.props.showPauseToggle) {
          var pauseIconType = this.state.paused ? "play-circle" : "pause-circle";
          var words = this.state.paused ? "Cycle Pages"  : "Pause Page Cycling";
          var pauseIcon = UniversalDashboard.renderComponent({type: 'icon', icon: pauseIconType});

          pauseToggle = [<Divider/>,
                         <ListItem onClick={this.onTogglePauseCycling.bind(this)}><ListItemIcon>{pauseIcon}</ListItemIcon><ListItemText>{words}</ListItemText></ListItem>
                        ]
      }

      return [links, pauseToggle]
  }

  renderCustomNavigation() {
    var children = [];
    if (this.state.content) {
        children = this.state.content.map(item => {
            return this.renderSideNavItem(item)
        })
    }
    
    return children;
}

    render() {
        const { classes } = this.props;
        const { open } = this.state;

        var fixed = this.props.navigation && this.props.navigation.fixed;

        var links = null;
        if (this.props.links) {
            links = this.props.links.map(function(x) {
                return <li key={x.url}>{UniversalDashboard.renderComponent(x)}</li>
            });
        }

        var logo = null;
        if (this.props.logo) {
            logo = <img id={this.props.logo.attributes.id} src={this.props.logo.attributes.src} height={this.props.logo.attributes.height} width={this.props.logo.attributes.width} style={{paddingLeft: '10px', verticalAlign: "middle"}}/>
        }

        var dPage = this.homePage();
        if(dPage == null){
            dPage = this.props.pages[0];
        }

        var href = dPage.name;
        if (href != null) {
            href = window.baseUrl + `/${dPage.name.replace(/ /g, "-")}`;
        }

        var iconButton = null;
        if (!this.props.none && (this.props.pages.length > 0 || this.state.content != null)) {
            iconButton = <IconButton
                color="inherit"
                aria-label="Open drawer"
                onClick={this.handleDrawerOpen}
                className={classNames(classes.menuButton, open && classes.hide, "menu-button")}
            >
                <MenuIcon />
            </IconButton>

            var navlinks = null;
            if (this.state.customNavigation) {
              navlinks = this.renderCustomNavigation();
            } else {
              navlinks = this.renderDefaultNavigation();
            }
        }

        var chevron = null;
        if (!this.props.navigation.fixed) {
          chevron =  <IconButton onClick={this.handleDrawerClose}>
            <ChevronLeftIcon />
          </IconButton>
        }

        return [
            <AppBar position="static" style={{backgroundColor: this.props.backgroundColor, color: this.props.fontColor}} className={classNames("ud-navbar", fixed && classes.appBarFixed, !fixed && classes.appBar)}>
                <Toolbar>
                    {iconButton}
                    <Typography variant="h6" color="inherit" className={classNames(fixed && classes.grow)}>
                        <a href={href}>
                            {logo}  <span id="ud-title">{this.props.text}</span>
                        </a>
                    </Typography>
                    {
                        this.props.authenticated ?
                        <a href="#!" onClick={this.signOut.bind(this)} className="right" style={{paddingRight: '10px'}} id="signoutLink"><span>Sign Out</span></a> :
                        <React.Fragment/>
                    }
                    <ul>
                        {links}
                    </ul>
                </Toolbar>
            </AppBar>,
            <Drawer
                className={fixed ? classes.drawerFixed : classes.drawer}
                variant={this.props.navigation.fixed ? "permanent" : null}
                anchor="left"
                open={open}
                onClick={this.handleDrawerClose}
                onKeyDown={this.handleDrawerClose}
                classes={{
                    paper: fixed ? classes.drawerPaperFixed : classes.drawerPaper,
                }}
            >
            <div className={classes.drawerHeader}>
                {chevron}
            </div>
            <Divider />
            {navlinks}
          </Drawer>
        ]
    }
}

class NavSideItem extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
       open: false
    }
  }

  handleClick = () => {
    this.setState(state => ({ open: !state.open }));
  };

  onItemClick(e) {

    if (this.props.children) {
        this.handleClick();
    }

    if (this.props.url == null) {
      if (this.props.hasCallback) {
          e.preventDefault(); 

          UniversalDashboard.publish('element-event', {
              type: "clientEvent",
              eventId: this.props.id,
              eventName: 'onClick'
          });
      }
    }
    else if (this.props.url != null && this.props.url.startsWith("http") || this.props.url.startsWith("https")) 
    {
        window.location.href = this.props.url;
    }

    if (this.props.url) {
      this.props.history.push(`/${this.props.url.replace(/ /g, "-")}`);      
    }
    
    if (this.props.name) {
      this.props.history.push(`/${this.props.name.replace(/ /g, "-")}`);      
    }
  }

  render() {
    if (this.props.divider) {
        return  <Divider key={this.props.id}></Divider>
    }

    var icon = null;
    if (this.props.icon !== 'none') {
        icon = <ListItemIcon id={this.props.id}>{UniversalDashboard.renderComponent({type: 'icon', icon: this.props.icon})}</ListItemIcon>
    }

    var text = this.props.name ? this.props.name : this.props.text;

    if (this.props.subheader) {
        return <ListItem id={this.props.id} button key={this.props.id}>{icon}<ListItemText>{text}</ListItemText></ListItem>
    }

    if(this.props.children == null) 
    {
        return <ListItem id={this.props.id} button key={this.props.id} onClick={function(e) { this.onItemClick(e)}.bind(this)}>{icon}<ListItemText>{text}</ListItemText></ListItem>
    }

    var children = this.props.children.map(x => <NavSideItem {...x} handleDrawerClose={this.props.handleDrawerClose} history={this.props.history}/>);
    return [<ListItem id={this.props.id} button key={this.props.id} onClick={this.handleClick}>{icon}<ListItemText inset primary={text}/> {this.state.open ? <ExpandLess /> : <ExpandMore />}</ListItem>, <Collapse key={this.props.id}  in={this.state.open} timeout="auto" unmountOnExit><List component="div" disablePadding>{children}</List></Collapse>]

  }
}

export default withStyles(styles)(UdNavbar);