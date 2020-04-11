import React, { useState, Suspense } from 'react';

import Chip from "./chips";
import Icon from "./icon";
import Paper from "./paper";
import IconButton from "./icon-button";
import { UDList, UDListItem } from "./list";
import Button from "./button";
import UDMuCard from "./card";
import UDCardMedia from "./card-media";
import UDCardToolBar from "./card-toolbar";
import UDCardHeader from "./card-header";
import UDCardBody from "./card-body";
import UDCardExpand from "./card-expand";
import UDCardFooter from "./card-footer";
import UDMuTypography from "./typography";
import UDLink from "./link";
import UDAvatar from "./avatar";
import UDCheckBox from "./checkbox";
import Progress from './progress';
import ExpansionPanelGroup from './expansion-panel';
import FloatingActionButton from './floating-action-button';
import Tabs from './tabs';
import Grid from './grid';
import Table from './table';
import Select from './select';
import Textbox from './textbox';
import UDSwitch from './switch';
import UDTreeView from './treeview';
import UDDynamic from './dynamic';
import UDForm from './form';
import UDDatePicker from './datepicker';
import UDTimePicker from './timepicker';
import UDNavbar from './framework/ud-navbar';
import UDFooter from './framework/ud-footer';
import UDAppBar from './appbar';
import UDDrawer from './drawer';
import {UDRadioGroupWithContext, UDRadio } from './radio';
import NotFound from './framework/not-found';
import UDContainer from './container';
import UDAutocomplete from './autocomplete';
import UDErrorCard from './framework/error-card';
import {UDStep, UDStepper} from './stepper';
import UDSlider from './slider'

import {
    Route,
    Redirect,
    Switch
} from 'react-router-dom'

UniversalDashboard.register("mu-chip", Chip);
UniversalDashboard.register("mu-icon", Icon);
UniversalDashboard.register("mu-paper", Paper);
UniversalDashboard.register("mu-icon-button", IconButton);
UniversalDashboard.register("mu-list", UDList);
UniversalDashboard.register("mu-list-item", UDListItem);
UniversalDashboard.register("mu-button", Button);
UniversalDashboard.register("mu-card", UDMuCard);
UniversalDashboard.register("mu-card-media", UDCardMedia);
UniversalDashboard.register("mu-card-toolbar", UDCardToolBar);
UniversalDashboard.register("mu-card-header", UDCardHeader);
UniversalDashboard.register("mu-card-body", UDCardBody);
UniversalDashboard.register("mu-card-expand", UDCardExpand);
UniversalDashboard.register("mu-card-footer", UDCardFooter);
UniversalDashboard.register("mu-typography", UDMuTypography);
UniversalDashboard.register("mu-link", UDLink);
UniversalDashboard.register("mu-avatar", UDAvatar);
UniversalDashboard.register("mu-checkbox", UDCheckBox);
UniversalDashboard.register("mu-progress", Progress);
UniversalDashboard.register('mu-expansion-panel-group', ExpansionPanelGroup);
UniversalDashboard.register('mu-fab', FloatingActionButton);
UniversalDashboard.register('mu-tabs', Tabs);
UniversalDashboard.register('mu-grid', Grid);
UniversalDashboard.register('mu-table', Table);
UniversalDashboard.register('mu-select', Select);
UniversalDashboard.register('mu-textbox', Textbox);
UniversalDashboard.register('mu-switch', UDSwitch);
UniversalDashboard.register('mu-treeview', UDTreeView);
UniversalDashboard.register('dynamic', UDDynamic);
UniversalDashboard.register('mu-form', UDForm);
UniversalDashboard.register('mu-datepicker', UDDatePicker);
UniversalDashboard.register('mu-timepicker', UDTimePicker);
UniversalDashboard.register('ud-navbar', UDNavbar);
UniversalDashboard.register('ud-footer', UDFooter);
UniversalDashboard.register('mu-appbar', UDAppBar);
UniversalDashboard.register('mu-drawer', UDDrawer);
UniversalDashboard.register('mu-radio', UDRadio);
UniversalDashboard.register('mu-radiogroup', UDRadioGroupWithContext);
UniversalDashboard.register('mu-container', UDContainer);
UniversalDashboard.register("mu-autocomplete", UDAutocomplete);
UniversalDashboard.register("error", UDErrorCard);
UniversalDashboard.register("mu-stepper-step", UDStep);
UniversalDashboard.register("mu-stepper", UDStepper);
UniversalDashboard.register("mu-slider", UDSlider);

// Framework Support
import UdPage from './framework/ud-page';
import UDModal from './framework/ud-modal';
import UdFooter from './framework/ud-footer';

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

    if (defaultHomePage.url != null && defaultHomePage.url.indexOf(":") === -1) {
        return <Redirect to={defaultHomePage.url} />
    }
    else {
        return <Suspense fallback={<div></div>}>
            <UDErrorCard message="Your first page needs page without a variable in the URL." />
        </Suspense>
    }
}

const MaterialUI = (props) => {
    var { dashboard } = props;

    var pages = dashboard.pages.map(function (x) {

        if (!x.url) {
            x.url = x.name;
        }

        if (!x.url.startsWith("/")) {
            x.url = "/" + x.url;
        }

        return <Route key={x.url} path={window.baseUrl + x.url} exact={x.url.indexOf(":") === -1} render={props => (
            <UdPage 
                id={x.id} dynamic={true} 
                {...x} 
                {...props} 
                autoRefresh={x.autoRefresh} 
                refreshInterval={x.refreshInterval} 
                key={props.location.key} 
                pages={dashboard.pages}
            />
        )} />
    })

    return [
        <Suspense fallback={<span />}>
            <Switch>
                {pages}
                <Route exact path={window.baseUrl + `/`} render={() => redirectToHomePage(dashboard)} />
                <Route path={window.baseUrl + `/`} render={() => <NotFound />} />
            </Switch>
        </Suspense>,
        <Suspense fallback={<div></div>}>
            <UDModal />
        </Suspense>
    ]

}

UniversalDashboard.renderDashboard = ({ dashboard, history }) => <MaterialUI dashboard={dashboard} history={history} />;