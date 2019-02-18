import React from 'react';
import {Link} from 'react-router-dom';
import UdIcon from './ud-icon.jsx';

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

    componentDidUpdate() {
        $(".collapsible").collapsible();

        if (this.props.fixed) {
            $(".button-collapse").sideNav({
                menuWidth: this.props.width,
                closeOnClick: true
            });
        }
        else {
            $(".menu-button").sideNav({
                menuWidth: this.props.width,
                closeOnClick: true
            });
        }
    }

    componentDidMount() {
        $(".collapsible").collapsible();

        if (this.props.fixed) {
            $(".button-collapse").sideNav({
                menuWidth: this.props.width,
                closeOnClick: true
            });
        }
        else {
            $(".menu-button").sideNav({
                menuWidth: this.props.width,
                closeOnClick: true
            });
        }
    }

    onItemClick(e, item) {
        if (item.hasCallback) {
            e.preventDefault(); 

            UniversalDashboard.publish('element-event', {
                type: "clientEvent",
                eventId: item.id,
                eventName: 'onClick'
            });
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

        return   [<div className="side-nav ud-page-navigation" id="navigation" >
                                        <div className="nav-wrapper">
                                        <ul className="right" style={{width: '100%'}}>
                                            {links}
                                            {pauseToggle}
                                        </ul>
                                    </div>
                </div>,
                <a href="#" className="menu-button" data-activates="navigation" style={{marginLeft: '25px', fontSize: '2.1rem'}}><UdIcon icon="bars"/></a>]
    }

    renderSideNavItem(item) {
        if (item.divider) {
            return  <li key={item.id}><div className="divider"></div></li>
        }

        var itemClass = "";
        if (item.subheader) {
            itemClass = "subheader";
        }

        var icon = null;
        if (item.icon !== 'none') {
            icon = <i className={`fa fa-${item.icon}`}></i>
        }

        if(item.children == null) 
        {
            if (item.url === null) {
                return <li key={item.id}><a href="#" onClick={function(e) { this.onItemClick(e, item)}.bind(this)} className={itemClass}>{icon} {item.text}</a></li>
            }
            else if (item.url.startsWith("http") || item.url.startsWith("https")) 
            {
                return <li key={item.id}><a href={item.url} className={itemClass}>{icon} {item.text}</a></li>
            }
            else 
            {
                return <li key={item.id}><Link to={window.baseUrl + "/" + item.url.replace(/ /g, "-")}><UdIcon icon={item.icon}/> {item.text}</Link></li>
            }
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

    renderCustomNavigation() {
        if (this.props.none) { return <div/> }

        var sideNavClass = "side-nav ud-page-navigation";
        var toggleButton = <a href="#" className="menu-button" data-activates="navigation" style={{marginLeft: '25px', fontSize: '2.1rem'}}><UdIcon icon="bars"/></a>;
        if (this.props.fixed) {
            sideNavClass += " fixed";
            toggleButton = <a href="#" className="button-collapse" data-activates="navigation" style={{marginLeft: '25px', fontSize: '2.1rem'}}><UdIcon icon="bars"/></a>;;
        }

        var children = [];
        if (this.state.content) {
            children = this.state.content.map(item => {
                return this.renderSideNavItem(item)
            })
        }
        
        return (
            [
                <div className={sideNavClass} id="navigation" >
                    <div className="nav-wrapper">
                        <ul className="right" style={{width: '100%'}}>
                            {children}
                        </ul>
                    </div>
                </div>,
                toggleButton
            ]
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