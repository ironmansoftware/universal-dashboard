import React, { useState, Suspense } from 'react';

import Chip from "./chips";
import Icon from "./icon";
import Paper from "./paper";
import IconButton from "./icon-button";
import List from "./list";
import Button from "./button";
import UDMuCard from "./card";
import UDCardMedia from "./card-media";
import UDCardToolBar from "./card-toolbar";
import UDCardHeader from "./card-header";
import UDCardBody from "./card-body";
import UDCardExpand from "./card-expand";
import UDCardFooter from "./card-footer";
import Typography from "./typography";
import UDLink from "./link";
import UDAvatar from "./avatar";
import UDCheckBox from "./checkbox";
import Progress from './progress';
import ExpansionPanelGroup from './expansion-panel';
import FloatingActionButton from './floating-action-button';
import Tabs from './tabs';
import Grid from './grid';

import {
    Route,
    Redirect,
    Switch
} from 'react-router-dom'

// import Pdf from "./pdf"; //this version has a bug render text not correct.

UniversalDashboard.register("mu-chip", Chip);
UniversalDashboard.register("mu-icon", Icon);
UniversalDashboard.register("mu-paper", Paper);
UniversalDashboard.register("mu-icon-button", IconButton);
UniversalDashboard.register("mu-list", List);
UniversalDashboard.register("mu-list-item", List);
UniversalDashboard.register("mu-button", Button);
UniversalDashboard.register("mu-card", UDMuCard);
UniversalDashboard.register("mu-card-media", UDCardMedia);
UniversalDashboard.register("mu-card-toolbar", UDCardToolBar);
UniversalDashboard.register("mu-card-header", UDCardHeader);
UniversalDashboard.register("mu-card-body", UDCardBody);
UniversalDashboard.register("mu-card-expand", UDCardExpand);
UniversalDashboard.register("mu-card-footer", UDCardFooter);
UniversalDashboard.register("mu-typography", Typography);
UniversalDashboard.register("mu-link", UDLink);
UniversalDashboard.register("mu-avatar", UDAvatar);
UniversalDashboard.register("mu-checkbox", UDCheckBox);
UniversalDashboard.register("mu-progress", Progress);
UniversalDashboard.register('mu-expansion-panel-group', ExpansionPanelGroup);
UniversalDashboard.register('mu-fab', FloatingActionButton);
UniversalDashboard.register('mu-tabs', Tabs);
UniversalDashboard.register('mu-grid', Grid);

// UniversalDashboard.register("ud-pdf", Pdf);

// Framework Support
import UdPage from './framework/ud-page';
import UDNavbar from './framework/ud-navbar';
import UdFooter from './framework/ud-footer';
import PageCycler from './framework/page-cycler';
import UDModal from './framework/ud-modal';



function getDefaultHomePage(dashboard) {
    return dashboard.pages.find(function (page) {
        return page.defaultHomePage === true;
    });
}

function redirectToHomePage(dashboard) {
    var defaultHomePage = getDefaultHomePage(dashboard);

    if (defaultHomePage == null) {
        defaultHomePage = dashboard.pages[0];
    }

    if (defaultHomePage != null && defaultHomePage.url == null) {
        return <Redirect to={window.baseUrl + `/${defaultHomePage.name.replace(/ /g, "-")}`} />
    }
    else if (defaultHomePage.url != null && defaultHomePage.url.indexOf(":") === -1) {
        return <Redirect to={defaultHomePage.url} />
    }
    else if (defaultHomePage.name == null) {
        return <Suspense fallback={<div></div>}>
            <UDErrorCard message="Your first page needs to be a static page or a dynamic page without a variable in the URL." />
        </Suspense>
    }
    else {
        return <Redirect to={window.baseUrl + `/${defaultHomePage.name.replace(/ /g, "-")}`} />
    }
}

class MaterialUI extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            title: props.dashboard.title,
            pausePageCycle: false
        }
    }

    setTitle(title) {
        this.setState({ title });
    }

    togglePageCycle() {
        this.setState({
            pausePageCycle: !this.state.pausePageCycle
        })
    }

    render() {
        var { dashboard } = this.props;

        var component = this;

        var dynamicPages = dashboard.pages.map(function (x) {
            if (!x.dynamic) return null;

            if (!x.url.startsWith("/")) {
                x.url = "/" + x.url;
            }

            return <Route key={x.url} path={window.baseUrl + x.url} render={props => (
                <UdPage onTitleChanged={component.setTitle.bind(component)} id={x.id} dynamic={true} {...x} {...props} autoRefresh={x.autoRefresh} refreshInterval={x.refreshInterval} key={props.location.key} />
            )} />
        })

        var staticPages = dashboard.pages.map(function (x) {
            if (x.dynamic) return null;

            return <Route key={x.name} exact path={window.baseUrl + '/' + x.name.replace(/ /g, "-")} render={props => (
                <UdPage onTitleChanged={component.setTitle.bind(component)} dynamic={false} {...x} {...props} autoRefresh={x.autoRefresh} refreshInterval={x.refreshInterval} key={props.location.key} />
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
        <main style={{ background: dashboard.backgroundColor, color: dashboard.fontColor }}>
            <Suspense fallback={<span />}>
                <Switch>
                    {staticPages}
                    {dynamicPages}
                    <Route exact path={window.baseUrl + `/`} render={() => redirectToHomePage(dashboard)} />
                    <Route path={window.baseUrl + `/`} render={() => <NotFound />} />
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

UniversalDashboard.renderDashboard = ({ dashboard, history }) => <MaterialUI dashboard={dashboard} history={history} />;