import React, { Suspense } from 'react';
import '@fontsource/roboto';

const Chip = React.lazy(() => import("./chips"));
const Icon = React.lazy(() => import("./icon"));
const Paper = React.lazy(() => import("./paper"));
const IconButton = React.lazy(() => import("./icon-button"));
import { UDList, UDListItem } from "./list";
const UDButton = React.lazy(() => import("./button"));
const UDMuCard = React.lazy(() => import("./card"));
const UDCardMedia = React.lazy(() => import("./card-media"));
const UDCardToolBar = React.lazy(() => import("./card-toolbar"));
const UDCardHeader = React.lazy(() => import("./card-header"));
const UDCardBody = React.lazy(() => import("./card-body"));
const UDCardExpand = React.lazy(() => import("./card-expand"));
const UDCardFooter = React.lazy(() => import("./card-footer"));
const Typography = React.lazy(() => import("./typography"));
const UDLink = React.lazy(() => import("./link"));
const UDAvatar = React.lazy(() => import("./avatar"));
const UDCheckBox = React.lazy(() => import("./checkbox"));
const Progress = React.lazy(() => import('./progress'));
const AccordionGroup = React.lazy(() => import('./expansion-panel'));
const FloatingActionButton = React.lazy(() => import('./floating-action-button'));
const Tabs = React.lazy(() => import('./tabs'));
const Grid = React.lazy(() => import('./grid'));
const Transition = React.lazy(() => import('./transition'));
const Table = React.lazy(() => import('./table/v2/table'));
const Select = React.lazy(() => import('./select'));
const Textbox = React.lazy(() => import('./textbox'));
const UDSwitch = React.lazy(() => import('./switch'));
const UDTreeView = React.lazy(() => import('./treeview'));
const UDDynamic = React.lazy(() => import('./dynamic'));
const UDForm = React.lazy(() => import('./form'));
const UDDatePicker = React.lazy(() => import('./datepicker'));
const UDTimePicker = React.lazy(() => import('./timepicker'));
const UDNavbar = React.lazy(() => import('./framework/ud-navbar'));
const UDAppBar = React.lazy(() => import('./appbar'));
const UDDrawer = React.lazy(() => import('./drawer'));
import { UDRadioGroupWithContext, UDRadio } from './radio';
const NotFound = React.lazy(() => import('./framework/not-found'));
const UDContainer = React.lazy(() => import('./container'));
const UDAutocomplete = React.lazy(() => import('./autocomplete'));
const UDErrorCard = React.lazy(() => import('./framework/error-card'));
import { UDStep, UDStepper } from './stepper';
const UDSlider = React.lazy(() => import('./slider'))
const UDUpload = React.lazy(() => import('./upload'))
import { Button } from '@mui/material';
const DateTime = React.lazy(() => import('./datetime'));
const UDAlert = React.lazy(() => import('./alert'));
const UDSkeleton = React.lazy(() => import('./skeleton'));
const UDBackdrop = React.lazy(() => import('./backdrop'));
const UDHidden = React.lazy(() => import('./hidden'));
const UDTransferList = React.lazy(() => import('./transfer-list'));
const UDMenu = React.lazy(() => import('./menu'));
const UDStyle = React.lazy(() => import('./style'));
const UDMonacoEditor = React.lazy(() => import('./code-editor'));
const UDEditor = React.lazy(() => import('./editor'));
const GridLayout = React.lazy(() => import('./grid-layout'));
const UDStack = React.lazy(() => import('./stack'));
const SchemaForm = React.lazy(() => import('./schema-form'));
const UDTimeline = React.lazy(() => import('./timeline'));
const UDBadge = React.lazy(() => import('./badge'));
import NotAuthorized from './framework/not-authorized';

require('./map/index');
require('./charts/index');

import {
    Route,
    Redirect,
    Switch
} from 'react-router-dom'

UniversalDashboard.register("ud-grid-layout", GridLayout);
UniversalDashboard.register("mu-chip", Chip);
UniversalDashboard.register("mu-icon", Icon);
UniversalDashboard.register("mu-paper", Paper);
UniversalDashboard.register("mu-icon-button", IconButton);
UniversalDashboard.register("mu-list", UDList);
UniversalDashboard.register("mu-list-item", UDListItem);
UniversalDashboard.register("mu-button", UDButton);
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
UniversalDashboard.register('mu-expansion-panel-group', AccordionGroup);
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
UniversalDashboard.register("mu-upload", UDUpload);
UniversalDashboard.register("mu-datetime", DateTime);
UniversalDashboard.register("mu-transition", Transition);
UniversalDashboard.register("mu-alert", UDAlert);
UniversalDashboard.register("mu-skeleton", UDSkeleton);
UniversalDashboard.register("mu-backdrop", UDBackdrop);
UniversalDashboard.register("mu-hidden", UDHidden);
UniversalDashboard.register("mu-transfer-list", UDTransferList);
UniversalDashboard.register("mu-menu", UDMenu);
UniversalDashboard.register("ud-style", UDStyle);
UniversalDashboard.register("ud-monaco", UDMonacoEditor);
UniversalDashboard.register("ud-editor", UDEditor);
UniversalDashboard.register("mu-stack", UDStack);
UniversalDashboard.register("mu-schema-form", SchemaForm);
UniversalDashboard.register("mu-timeline", UDTimeline);
UniversalDashboard.register("mu-badge", UDBadge);

// Framework Support
import UdPage from './framework/ud-page';
import UDModal from './framework/ud-modal';

function getDefaultHomePage(pages) {
    return pages.find(function (page) {
        return page.defaultHomePage === true;
    });
}

function redirectToHomePage(pages) {

    if (pages == null || pages.length == 0) {
        window.location.href = "/login/unauthorized"
    }

    var defaultHomePage = getDefaultHomePage(pages);

    if (defaultHomePage == null) {
        defaultHomePage = pages[0];
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

const intersection = (arr1, arr2) => {
    const res = [];
    const { length: len1 } = arr1;
    const { length: len2 } = arr2;
    const smaller = (len1 < len2 ? arr1 : arr2).slice();
    const bigger = (len1 >= len2 ? arr1 : arr2).slice();
    for (let i = 0; i < smaller.length; i++) {
        if (bigger.indexOf(smaller[i]) !== -1) {
            res.push(smaller[i]);
            bigger.splice(bigger.indexOf(smaller[i]), 1, undefined);
        }
    };
    return res;
};

const MaterialUI = (props) => {
    var { dashboard, roles, user, windowsAuth } = props;

    var authedPages = dashboard.pages.filter(x => {
        if (!x.role) return true;
        if (!Array.isArray(x.role)) return true;
        if (!roles || roles.length == 0) return false;
        if (!Array.isArray(roles)) return false;
        if (intersection(roles, x.role).length == 0) return false;
        return true;
    });

    var pages = authedPages.map(function (x) {

        if (!x.url) {
            x.url = x.name;
        }

        if (!x.url.startsWith("/")) {
            x.url = "/" + x.url;
        }

        return <Route key={x.url} path={x.url} exact={x.url.indexOf(":") === -1} render={pageProps => (
            <UdPage
                id={x.id} dynamic={true}
                {...x}
                {...pageProps}
                navigation={x.navigation || dashboard.navigation}
                navigationLayout={x.navigationLayout || dashboard.navigationLayout}
                headerContent={x.headerContent || dashboard.headerContent}
                loadNavigation={x.loadNavigation || dashboard.loadNavigation}
                autoRefresh={x.autoRefresh}
                refreshInterval={x.refreshInterval}
                key={pageProps.location.key}
                disableThemeToggle={dashboard.disableThemeToggle}
                pages={authedPages}
                user={user}
                windowsAuth={windowsAuth}
            />
        )} />
    })

    var unauthedPages = dashboard.pages.filter(x => authedPages.filter(y => y.url === x.url).length === 0);
    if (dashboard.notAuthorized) {
        unauthedPages.forEach(x => {
            pages.push(<Route key={x.url} path={x.url} exact={x.url.indexOf(":") === -1} render={() => <NotAuthorized notAuthorized={dashboard.notAuthorized} />} />)
        })
    }

    return [
        <Suspense fallback={<span />}>
            <Switch>
                {pages}
                <Route exact path={`/`} render={() => redirectToHomePage(authedPages)} />
                <Route path={`/`} render={() => <NotFound pageNotFound={dashboard.pageNotFound} />} />
            </Switch>
        </Suspense>,
        <Suspense fallback={<div></div>}>
            <UDModal />
        </Suspense>
    ]
}

UniversalDashboard.onSessionTimedOut = () => {
    UniversalDashboard.disableFetchService();
    UniversalDashboard.publish('modal.open', {
        content: [<div id="sessionTimedOut">Your session has timed out</div>],
        footer: [<Button onClick={() => window.location.reload()}>Refresh Page</Button>]
    })
}

UniversalDashboard.renderDashboard = (props) => <MaterialUI {...props} />;