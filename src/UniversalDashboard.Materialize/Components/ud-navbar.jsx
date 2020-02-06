import React from 'react';
import UdNavigation from './ud-navigation.jsx';

import Typography from '@material-ui/core/Typography';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';

export default class UdNavbar extends React.Component {

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

    render() {
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

        return <AppBar style={{backgroundColor: this.props.backgroundColor, color: this.props.fontColor}} className="ud-navbar">
            <Toolbar>
                <a href={href}>
                    <Typography variant="h6">
                        {this.props.text}
                    </Typography>
                </a>
            </Toolbar>
        </AppBar>
      

        return <nav style={{backgroundColor: this.props.backgroundColor, color: this.props.fontColor}} className="ud-navbar">
                    <UdNavigation 
                        pages={this.props.pages} 
                        togglePaused={this.props.togglePaused} 
                        showPauseToggle={this.props.showPauseToggle} 
                        {...this.props.navigation} 
                        customNavigation={this.props.navigation != null}
                        history={this.props.history}/>

                   
                    <a href={href} style={{paddingLeft: '10px', fontSize: '2.1rem'}}>
                        {logo}  <span id="udtitle">{this.props.text}</span>
                    </a>
                    {
                        this.props.authenticated ?
                        <a href="#!" onClick={this.signOut.bind(this)} className="right" style={{paddingRight: '10px'}} id="signoutLink"><span>Sign Out</span></a> :
                        <React.Fragment/>
                    }
                    <ul id="nav-mobile" className="right hide-on-med-and-down">
                        {links}
                    </ul>
                </nav>;
    }
}