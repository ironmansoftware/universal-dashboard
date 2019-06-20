import React from 'react';
import {Link} from 'react-router-dom';
import UdIcon from './ud-icon';
import cx from 'classnames';

import { SideNav, SideNavItem, Button, Collapsible, CollapsibleItem} from 'react-materialize';

export default class UdNavigation extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            paused: false,
            content: props.content
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

   

    onTogglePauseCycling() {
        this.props.togglePaused();
        this.setState({
            paused: !this.state.paused
        })
    }

    renderDefaultNavigation() {
        if (!this.props.pages || this.props.pages.length === 1) return <div/>;

        var links = this.props.pages.map(function(x, i) {

            if (x.name == null) return null;

            return this.renderSideNavItem(x);
        }.bind(this))

        var pauseToggle = null;
        if (this.props.showPauseToggle) {
            var pauseIcon = this.state.paused ? "PlayCircle" : "PauseCircle";
            var words = this.state.paused ? "Cycle Pages"  : "Pause Page Cycling";

            pauseToggle = [<SideNavItem divider />,
                           <SideNavItem onClick={this.onTogglePauseCycling.bind(this)}><UdIcon icon={pauseIcon}/> {words}</SideNavItem>
                          ]
        }

        return <SideNav ref={x => this.sideNav = x} trigger={<a style={{cursor: 'pointer'}} id='sidenavtrigger'><UdIcon icon="Bars" /></a>} options={{closeOnClick: true}}>
            {links}
            {pauseToggle}
        </SideNav> 
    }

    renderSideNavItem(item) {
        if (item.divider) {
            return  <SideNavItem divider />
        }

        if(item.children == null) 
        {
            return <UDSideNavItem {...item} history={this.props.history} parent={this} fixed={this.props.fixed}/>
        }
        else 
        {
            var children = item.children.map(x => this.renderSideNavItem(x));

            var icon = item.icon;
            var header = [icon && <UdIcon icon={icon} style={{width: '30px', marginTop: '15px'}}/>, item.text]

            return  <li><Collapsible accordion>
                        <CollapsibleItem header={header} style={{color: 'black', paddingLeft: '15px'}} id={item.id}>
                            <ul>
                                {children}
                            </ul>
                        </CollapsibleItem>
                    </Collapsible></li>
            
        }
    }

    renderCustomNavigation() {
        if (this.props.none) { return <div/> }

        var children = [];
        if (this.state.content) {
            children = this.state.content.map(item => {
                return this.renderSideNavItem(item)
            })
        }
        
        return (
            <SideNav ref={x => this.sideNav = x} fixed={this.props.fixed} trigger={<a style={{cursor: 'pointer'}} id='sidenavtrigger'><UdIcon icon="Bars" /></a>} options={{closeOnClick: true}}>
                {children}
            </SideNav>
        )
    }

    render() {
        if (this.props.customNavigation) {
            return this.renderCustomNavigation();
        } else {
            return this.renderDefaultNavigation();
        }

    }
}

class UDSideNavItem extends React.Component {

    onItemClick(e) {
        e.preventDefault(); 

        if (this.props.hasCallback) {
            PubSub.publish('element-event', {
                type: "clientEvent",
                eventId: this.props.id,
                eventName: 'onClick'
            });
        }
        else if (this.props.url != null && (this.props.url.startsWith("http") || this.props.url.startsWith("https"))) 
        {
            window.location.href = this.props.url;
        }
        else if (this.props.url != null) {
            this.props.history.push(`/${this.props.url.replace(/ /g, "-")}`);      
        }
        else if (this.props.name != null) {
          this.props.history.push(`/${this.props.name.replace(/ /g, "-")}`);      
        }

        if (!this.props.fixed) {
            this.props.parent.sideNav.instance.close();
        }
    }

    render() {
        const {
            subheader,
            icon,
            href = '#!',
            waves,
            text,
            name,
            ...props
          } = this.props;
          const linkClasses = {
            subheader: subheader,
            'waves-effect': waves
          };

          var linkText = text ? text : name;
      
          return (
            <li {...props}>
              {(
                <a className={cx(linkClasses)} href={href} onClick={this.onItemClick.bind(this)}>
                  {icon && <UdIcon icon={icon} style={{width: '30px'}}/>}   {linkText}
                </a>
              )}
            </li>
          );
    }
}