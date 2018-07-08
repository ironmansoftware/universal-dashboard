import React from 'react';
import UdNavigation from './ud-navigation.jsx';
import UdLink from './ud-link.jsx';
import {fetchGet} from './services/fetch-service.jsx';

export default class UdNavbar extends React.Component {

    signOut() {
        fetchGet("/signout", function() {
            this.props.history.push("/login");
        }.bind(this));
    }

    render() {
        var links = null;
        if (this.props.links) {
            links = this.props.links.map(function(x) {
                return <li key={x.url}><UdLink {...x}  /></li>
            });
        }

        var logo = null;
        if (this.props.logo) {
            logo = <img id={this.props.logo.id} src={this.props.logo.url} height={this.props.logo.height} width={this.props.logo.width} style={{paddingLeft: '10px', verticalAlign: "middle"}}/>
        }

        return <nav style={{backgroundColor: this.props.backgroundColor, color: this.props.fontColor}} className="ud-navbar">
                    <UdNavigation pages={this.props.pages} togglePaused={this.props.togglePaused} showPauseToggle={this.props.showPauseToggle}/>
                   
                    <a href="#!" style={{paddingLeft: '10px', fontSize: '2.1rem'}}>
                        {logo}  <span>{this.props.text}</span>
                    </a>
                    {
                        this.props.authenticated ?
                        <a href="#!" onClick={this.signOut.bind(this)} className="right" style={{paddingRight: '10px'}} id="signoutLink"><span>Sign Out</span></a> :
                        <div/>
                    }
                    <ul id="nav-mobile" className="right hide-on-med-and-down">
                        {links}
                    </ul>
                </nav>;
    }
}