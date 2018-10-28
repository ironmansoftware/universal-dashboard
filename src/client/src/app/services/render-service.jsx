import React from 'react';
const UdCard = React.lazy(() => import( './../ud-card.jsx'));
const UdChart = React.lazy(() => import( './../ud-chart.jsx'));
const UdColumn = React.lazy(() => import('./../ud-column.jsx'));
const UdCounter = React.lazy(() => import( './../ud-counter.jsx'));
const UdElement = React.lazy(() => import( './../ud-element.jsx'));
const UdGrid = React.lazy(() => import('./../ud-grid.jsx'));
const UdHtml = React.lazy(() => import('./../ud-html.jsx'));
const UdLink = React.lazy(() => import('./../ud-link.jsx')) ;
const UdInput = React.lazy(() => import( './../ud-input.jsx'));
const UdMonitor = React.lazy(() => import('./../ud-monitor.jsx')) ;
const UdNavbar = React.lazy(() => import('./../ud-navbar.jsx'));
const UdRow = React.lazy(() => import('./../ud-row.jsx')) ;
const ErrorCard = React.lazy(() => import('./../error-card.jsx')) ;
const DateTime = React.lazy(() => import('./../basics/datetime.jsx')) ;
const UDTreeView = React.lazy(() => import('./../ud-treeview.jsx')) ;
const UDImageCarousel = React.lazy(() => import('./../ud-image-carousel.jsx'));

export default function renderComponent(component, history) {
    if (!component) return null;

    var pluginComponent = null;
    window.UniversalDashboard.plugins.some(plugin => {
        if (plugin.components == null) return false;

        pluginComponent = plugin.components.find(component.type === component.type);
        return pluginComponent != null;
    });

    if (pluginComponent != null) {
        return React.createElement(pluginComponent, component);
    }

    switch(component.type) {
        case "card":   
            return <UdCard {...component} key={component.id} />;
        case "chart":
            return <UdChart {...component} key={component.id}/>;
        case "column":
            return <UdColumn {...component} key={component.id} history={history} />;
        case "counter":
            return <UdCounter {...component} key={component.id}/>;
        case "datetime":
            return <DateTime {...component} key={component.id}/>;
        case "element":
            return <UdElement {...component} key={component.id} history={history}/>;
        case "error":
            return <ErrorCard {...component} key={component.id}/>;
        case "grid":
            return <UdGrid {...component} key={component.id}/>;
        case "rawHtml":
            return <UdHtml {...component} key={component.id}/>;
        case "link":
            return <UdLink {...component} key={component.id}/>;
        case "input":
            return <UdInput {...component} key={component.id} history={history}/>;
        case "Monitor":
            return <UdMonitor {...component} key={component.id}/>;
        case "navbar":
            return <UdNavbar {...component} key={component.id}/>;
        case "row":
            return <UdRow {...component} key={component.id} history={history}/>;
        case "treeview":
            return <UDTreeView {...component} key={component.id} history={history}/>;
        case "imageCarousel":
            return <UDImageCarousel {...component} key={component.id}/>;
    }
}