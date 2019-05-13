import React from 'react';
import { AppBar, Toolbar, Typography, IconButton, Drawer, Divider, ListItem, ListItemIcon, ListItemText  } from '@material-ui/core';
import { withStyles } from '@material-ui/core/styles';
import MenuIcon from '@material-ui/icons/Menu';
import ChevronLeftIcon from '@material-ui/icons/ChevronLeft';
import classNames from "classnames"

const drawerWidth = 240;

const  styles = theme => ({
    root: {
      flexGrow: 1,
    },
    grow: {
      flexGrow: 1,
    },
    appBar: {
        transition: theme.transitions.create(['margin', 'width'], {
          easing: theme.transitions.easing.sharp,
          duration: theme.transitions.duration.leavingScreen,
        }),
      },
      appBarShift: {
        width: `calc(100% - ${drawerWidth}px)`,
        transition: theme.transitions.create(['margin', 'width'], {
          easing: theme.transitions.easing.easeOut,
          duration: theme.transitions.duration.enteringScreen,
        }),
        marginRight: drawerWidth,
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
        justifyContent: 'flex-start',
      },
      content: {
        flexGrow: 1,
        padding: theme.spacing.unit * 3,
        transition: theme.transitions.create('margin', {
          easing: theme.transitions.easing.sharp,
          duration: theme.transitions.duration.leavingScreen,
        }),
        marginRight: -drawerWidth,
      },
      contentShift: {
        transition: theme.transitions.create('margin', {
          easing: theme.transitions.easing.easeOut,
          duration: theme.transitions.duration.enteringScreen,
        }),
        marginRight: 0,
      },
  });

class UdNavbar extends React.Component {

    constructor(props) {
      super(props);

      this.state = {
          paused: false,
          content: props.content,
          open: false
      }
    }

    componentWillMount() {
        if (this.props.customNavigation && this.props.content === null) {
            UniversalDashboard.get(`/api/internal/component/element/${this.props.id}`, function(data) {
                this.setState({
                    content: data
                })
            }.bind(this));
        }
    }

    onItemClick(e, item) {
      if (item.url == null) {
        if (item.hasCallback) {
            e.preventDefault(); 

            PubSub.publish('element-event', {
                type: "clientEvent",
                eventId: item.id,
                eventName: 'onClick'
            });
        }
      }
      else if (item.url != null && item.url.startsWith("http") || item.url.startsWith("https")) 
      {
          window.location.href = item.url;
      }

      if (item.name) {
        this.props.history.push("/" + item.name);      
      }
      
      this.handleDrawerClose();
    }

    onTogglePauseCycling() {
        this.props.togglePaused();
        this.setState({
            paused: !this.state.paused
        })
    }

    renderSideNavItem(item) {
      if (item.divider) {
          return  <Divider key={item.id}></Divider>
      }

      var icon = null;
      if (item.icon !== 'none') {
          icon = <ListItemIcon>{UniversalDashboard.renderComponent({type: 'icon', icon: item.icon})}</ListItemIcon>
      }

      if(item.children == null) 
      {
          return <ListItem button key={item.id} onClick={function(e) { this.onItemClick(e, item)}.bind(this)}>{icon}<ListItemText>{item.name}</ListItemText></ListItem>
      }
      else 
      {
          var children = item.children.map(x => this.renderSideNavItem(x));
          return  <li className="no-padding">
                      <ul className="collapsible collapsible-accordion">
                      <li>
                          <a className="collapsible-header">{item.text}</a>
                          <div className="collapsible-body">
                          <ul>
                              {children}
                          </ul>
                          </div>
                      </li>
                      </ul>
                  </li>
      }
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
        const { classes, theme } = this.props;
        const { open } = this.state;

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
                className={classNames(classes.menuButton, open && classes.hide)}
            >
                <MenuIcon />
            </IconButton>

            var navlinks = null;
            if (this.props.customNavigation) {
              navlinks = this.renderCustomNavigation();
            } else {
              navlinks = this.renderDefaultNavigation();
            }
        }

        return [
            <AppBar position="static" style={{backgroundColor: this.props.backgroundColor, color: this.props.fontColor}} className="ud-navbar">
                <Toolbar>
                    {iconButton}
                    <Typography variant="h6" color="inherit" className={classes.grow}>
                        <a href={href} style={{paddingLeft: '10px', fontSize: '2.1rem', color: this.props.fontColor}}>
                            {logo}  <span id="ud-title">{this.props.text}</span>
                        </a>
                    </Typography>
                    {
                        this.props.authenticated ?
                        <a href="#!" onClick={this.signOut.bind(this)} className="right" style={{paddingRight: '10px'}} id="signoutLink"><span>Sign Out</span></a> :
                        <React.Fragment/>
                    }
                    <ul id="nav-mobile" className="right hide-on-med-and-down">
                        {links}
                    </ul>
                </Toolbar>
            </AppBar>,
            <Drawer
                className={classes.drawer}
                variant="persistent"
                anchor="left"
                open={open}
                classes={{
                    paper: classes.drawerPaper,
                }}
            >
            <div className={classes.drawerHeader}>
              <IconButton onClick={this.handleDrawerClose}>
                <ChevronLeftIcon />
              </IconButton>
            </div>
            <Divider />
            {navlinks}
          </Drawer>
        ]
    }
}

export default withStyles(styles)(UdNavbar);