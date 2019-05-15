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

            return <li key={x.name}><Link to={window.baseUrl + "/" + x.name.replace(/ /g, "-")}><UdIcon icon={x.icon}/> {x.name}</Link></li>;
        })

        var pauseToggle = null;
        if (this.props.showPauseToggle) {
            var pauseIcon = this.state.paused ? "play-circle" : "pause-circle";
            var words = this.state.paused ? "Cycle Pages"  : "Pause Page Cycling";

            pauseToggle = [<li><div class="divider"></div></li>,
                           <li><a href="#!" onClick={this.onTogglePauseCycling.bind(this)}><UdIcon icon={pauseIcon}/> {words}</a></li>
                          ]
        }

        return  [<ul className="right" style={{width: '100%'}} ref={el => (this._sidenav = el)}>
                    {links}
                    {pauseToggle}
                </ul>,
                <a href="#" className="menu-button" data-activates="navigation" style={{marginLeft: '25px', fontSize: '2.1rem'}}><UdIcon icon="bars"/></a>]
    }

    renderSideNavItem(item) {
        if (item.divider) {
            return  <SideNavItem divider />
        }

        if(item.children == null) 
        {
            return <UDSideNavItem {...item}/>
        }
        else 
        {
            var children = item.children.map(x => this.renderSideNavItem(x));
            return  <li><Collapsible accordion>
                        <CollapsibleItem header={item.text} style={{color: 'black', paddingLeft: '15px'}} >
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
            <SideNav fixed={this.props.fixed} trigger={<a>Test</a>}>
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

    onItemClick(e, item) {
        if (this.props.hasCallback) {
            e.preventDefault(); 

            PubSub.publish('element-event', {
                type: "clientEvent",
                eventId: item.id,
                eventName: 'onClick'
            });
        }
        else if (this.props.url != null && this.props.url.startsWith("http") || this.props.url.startsWith("https")) 
        {
            window.location.href = this.props.url;
        }
        else if (this.props.url) {
            this.props.history.push(`/${this.props.url.replace(/ /g, "-")}`);      
        }
        else if (this.props.name) {
          this.props.history.push(`/${this.props.name.replace(/ /g, "-")}`);      
        }
    }

    render() {
        const {
            subheader,
            icon,
            href = '#!',
            waves,
            text,
            ...props
          } = this.props;
          const linkClasses = {
            subheader: subheader,
            'waves-effect': waves
          };
      
          return (
            <li {...props}>
              {(
                <a className={cx(linkClasses)} href={href} onClick={this.onItemClick.bind(this)}>
                  {icon && <UdIcon icon={icon} />}   {text}
                </a>
              )}
            </li>
          );
    }
}