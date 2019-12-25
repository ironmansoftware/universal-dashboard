import React, { useState, Suspense } from 'react';

require('materialize-css/dist/css/materialize.min.css');

import TabContainer from './tabs';
import UDButton from './ud-button';
import UDChart from './ud-chart';
import UDCounter from './ud-counter';
import UDErrorCard from './error-card';
import UDGrid from './ud-grid';
import UDLink from './ud-link';
import UdImageCarousel from './ud-image-carousel';
import UDNavbar from './ud-navbar';
import UDNavigation from './ud-navigation';
import UdFooter from './ud-footer';
import UdInput from './ud-input';
import UdInputField from './ud-input-field';
import UdMonitor from './ud-monitor';
import UDModal from './ud-modal';
import UDCheckbox from './ud-checkbox';
import UDCollapsible from './ud-collapsible';
import UDSelect from './ud-select';
import UDGridLayout from './ud-grid-layout';
import UDFab from './ud-fab';
import UDTreeView from './ud-treeview';
import ErrorCard from './error-card';
import UdPage from './ud-page';
import Loading from './loading';
import NotFound from './not-found';

import {
    Route,
    Redirect,
    Switch
} from 'react-router-dom'

import PageCycler from './page-cycler';

UniversalDashboard.register("error", ErrorCard);
UniversalDashboard.register("ud-button", UDButton);
UniversalDashboard.register("ud-chart", UDChart);
UniversalDashboard.register("ud-counter", UDCounter);
UniversalDashboard.register("tab-container", TabContainer);
UniversalDashboard.register("image-carousel", UdImageCarousel);
UniversalDashboard.register("ud-errorcard", UDErrorCard);
UniversalDashboard.register("ud-grid", UDGrid);
UniversalDashboard.register("ud-footer", UdFooter);
UniversalDashboard.register("ud-link", UDLink);
UniversalDashboard.register("ud-monitor", UdMonitor);
UniversalDashboard.register("ud-navbar", UDNavbar);
UniversalDashboard.register("ud-udnavigation", UDNavigation);
UniversalDashboard.register("ud-input", UdInput);
UniversalDashboard.register("ud-input-field", UdInputField);
UniversalDashboard.register("ud-modal", UDModal);
UniversalDashboard.register("ud-checkbox", UDCheckbox);
UniversalDashboard.register("ud-collapsible", UDCollapsible);
UniversalDashboard.register("ud-select", UDSelect);
UniversalDashboard.register("ud-grid-layout", UDGridLayout);
UniversalDashboard.register("ud-fab", UDFab);
UniversalDashboard.register("ud-treeview", UDTreeView);
UniversalDashboard.register("loading", Loading);

function getDefaultHomePage(dashboard)
{
    return dashboard.pages.find(function(page){
        return page.defaultHomePage === true;
    });
}

function redirectToHomePage(dashboard) 
{
    var defaultHomePage = getDefaultHomePage(dashboard);
    
    if(defaultHomePage == null){
        defaultHomePage = dashboard.pages[0];
    }

    if(defaultHomePage != null && defaultHomePage.url == null){
        return <Redirect to={window.baseUrl + `/${defaultHomePage.name.replace(/ /g,"-")}`}/>
    }
    else if (defaultHomePage.url != null && defaultHomePage.url.indexOf(":") === -1) {
        return <Redirect to={defaultHomePage.url}/>
    }
    else if (defaultHomePage.name == null) {
        return <Suspense fallback={<div></div>}>
                    <UDErrorCard message="Your first page needs to be a static page or a dynamic page without a variable in the URL." />
                </Suspense>
    }
    else {
        return <Redirect to={window.baseUrl + `/${defaultHomePage.name.replace(/ /g,"-")}`}/>
    }
}

class Materialize extends React.Component 
{
    constructor(props) {
        super(props);

        this.state = {
            title: props.dashboard.title,
            pausePageCycle: false
        }
    }

    setTitle(title) {
        this.setState({title});
    }

    togglePageCycle() {
        this.setState({
            pausePageCycle: !this.state.pausePageCycle
        })
    }

    render()
    {
        var {dashboard} = this.props;

        var component = this;

        var dynamicPages = dashboard.pages.map(function(x) {
            if (!x.dynamic) return null;
    
            if (!x.url.startsWith("/")) {
                x.url = "/" + x.url;
            }
    
            return <Route key={x.url} path={window.baseUrl + x.url} render={props => (
                <UdPage onTitleChanged={component.setTitle.bind(component)} id={x.id} dynamic={true} {...props} autoRefresh={x.autoRefresh} refreshInterval={x.refreshInterval} key={props.location.key}/>
            )} />
        })
    
        var staticPages = dashboard.pages.map(function(x) {
            if (x.dynamic) return null;
    
            return <Route key={x.name} exact path={window.baseUrl + '/' + x.name.replace(/ /g, "-")} render={props => (
                <UdPage onTitleChanged={component.setTitle.bind(component)} dynamic={false} {...x} {...props} autoRefresh={x.autoRefresh} refreshInterval={x.refreshInterval} key={props.location.key}/>
            )} />
        })
    
        return [<header>
                    <UDNavbar backgroundColor={dashboard.navBarColor} 
                            fontColor={dashboard.navBarFontColor} 
                            text={this.state.title} 
                            links={dashboard.navbarLinks}
                            logo={dashboard.navBarLogo}
                            pages={dashboard.pages}
                            togglePaused={this.togglePageCycle.bind(this)} 
                            showPauseToggle={dashboard.cyclePages}
                            history={this.props.history}
                            navigation={dashboard.navigation}
                            />
                </header>,
                <main style={{background: dashboard.backgroundColor, color: dashboard.fontColor}}>
                    <Suspense fallback={<span/>}>
                        <Switch>
                            {staticPages}
                            {dynamicPages}
                            <Route exact path={window.baseUrl + `/`} render={() => redirectToHomePage(dashboard)} />
                            <Route path={window.baseUrl + `/`} render={() => <NotFound/>} />
                        </Switch>
                    </Suspense>
                </main>,
                <Suspense fallback={<div></div>}>
                    <UDModal />
                </Suspense>,
                <UdFooter backgroundColor={dashboard.navBarColor} fontColor={dashboard.navBarFontColor} footer={dashboard.footer} />,
                <Route path={window.baseUrl + `/`} render={function (x) {
                    return <Suspense fallback={<div></div>}>
                        <PageCycler history={x.history} pages={dashboard.pages} cyclePages={dashboard.cyclePages && !this.state.pausePageCycle} cyclePagesInterval={dashboard.cyclePagesInterval} />
                    </Suspense>
                    }.bind(this)}
                />]
    }
}

UniversalDashboard.renderDashboard = ({dashboard, history}) => <Materialize dashboard={dashboard} history={history} />;