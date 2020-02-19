import React, {useState} from 'react';
import { makeStyles } from '@material-ui/core/styles';

import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import MenuIcon from '@material-ui/icons/Menu';
import IconButton from '@material-ui/core/IconButton';

import List from '@material-ui/core/List';
import Divider from '@material-ui/core/Divider';
import ListItem from '@material-ui/core/ListItem';
import ListItemIcon from '@material-ui/core/ListItemIcon';
import ListItemText from '@material-ui/core/ListItemText';
import InboxIcon from '@material-ui/icons/MoveToInbox';
import MailIcon from '@material-ui/icons/Mail';

import Drawer from '@material-ui/core/Drawer';

const useStyles = makeStyles({
    list: {
      width: 250,
    },
    fullList: {
      width: 'auto',
    },
  });

    function onItemClick(props, e) {
        e.preventDefault(); 

        if (props.type === "side-nav-item" && props.hasCallback) {
            PubSub.publish('element-event', {
                type: "clientEvent",
                eventId: props.id,
                eventName: 'onClick'
            });
        }
        else if (props.url != null && (props.url.startsWith("http") || props.url.startsWith("https"))) 
        {
            window.location.href = props.url;
        }
        else if (props.url != null) {
            var url = props.url;
            if (!url.startsWith("/")) {
                url = "/" + url;
            }
            props.history.push(`${window.baseUrl + url.replace(/ /g, "-")}`);      
        }
        else if (props.name != null) {
            props.history.push(window.baseUrl + `/${props.name.replace(/ /g, "-")}`);      
        }
    }

function renderSideNavItem(item) {

    var linkText = item.text ? item.text : item.name;

    if (item.divider) {
        return  <Divider />
    }

    if(item.children == null) 
    {
        return <ListItem button onClick={(e) => onItemClick(item, e)}>
            <ListItemText>{linkText}</ListItemText>
        </ListItem>
    }
    else 
    {
        // var children = item.children.map(x => this.renderSideNavItem(x));

        // var icon = item.icon;
        // var header = [icon && <UdIcon icon={icon} style={{width: '30px', marginTop: '15px'}}/>, item.text]

        // return  <li><Collapsible accordion>
        //             <CollapsibleItem header={header} style={{color: 'black', paddingLeft: '15px'}} id={item.id}>
        //                 <ul>
        //                     {children}
        //                 </ul>
        //             </CollapsibleItem>
        //         </Collapsible></li>
    }
}

function renderDefaultNavigation(props) {
    if (!props.pages || props.pages.length === 1) return <div/>;

    var links = props.pages.map(function(x, i) {
        if (x.name == null) return null;
        return renderSideNavItem(x);
    })

    const classes = useStyles();

    return <div
            className={classes.list}
            role="presentation"
    >
    <List>
            {links}
        </List> 
    </div>
}

export default function UdNavbar(props) {

    const [open, setOpen] = useState(false);

    var links = null;
    if (props.links) {
        links = props.links.map(function(x) {
            return <li key={x.url}>{UniversalDashboard.renderComponent(x)}</li>
        });
    }

    var logo = null;
    if (props.logo) {
        logo = <img id={props.logo.attributes.id} src={props.logo.attributes.src} height={props.logo.attributes.height} width={props.logo.attributes.width} style={{paddingLeft: '10px', verticalAlign: "middle"}}/>
    }

    var dPage = props.pages.find(function(page){
        return page.defaultHomePage === true;
    });

    if(dPage == null){
        dPage = props.pages[0];
    }

    var href = dPage.name;
    if (href != null) {
        href = window.baseUrl + `/${dPage.name.replace(/ /g, "-")}`;
    }

    var menuButton = null;
    var drawer = null; 

    if (props.pages.length > 1)
    {
        var links = null;
        if (props.customNavigation) {
            links = renderCustomNavigation(props);
        } else {
            links = renderDefaultNavigation(props);
        }

        drawer = <Drawer open={open} onClose={() => setOpen(false)}>
             {links}
        </Drawer>

        menuButton = <IconButton edge="start" color="inherit" aria-label="menu" onClick={() => setOpen(true)} >
            <MenuIcon />
        </IconButton>
    }

    return [
        drawer,
        <AppBar position="static">
            <Toolbar>
                {menuButton}
                <Typography variant="h6">
                    {logo} {props.text}
                </Typography>
            </Toolbar>
        </AppBar>
    ]

        // return <nav style={{backgroundColor: this.props.backgroundColor, color: this.props.fontColor}} className="ud-navbar">
        //             <UdNavigation 
        //                 pages={this.props.pages} 
        //                 togglePaused={this.props.togglePaused} 
        //                 showPauseToggle={this.props.showPauseToggle} 
        //                 {...this.props.navigation} 
        //                 customNavigation={this.props.navigation != null}
        //                 history={this.props.history}/>

        //             <ul id="nav-mobile" className="right hide-on-med-and-down">
        //                 {links}
        //             </ul>
        //         </nav>;
}