import React from 'react';

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
            return import('./../ud-card.jsx').then(({ default: UdCard }) => {
                return <UdCard {...component} key={component.id} />;
            })
        case "chart":
            return import('./../ud-chart.jsx').then(({ default: UdChart }) => {
                return <UdChart {...component} key={component.id}/>;
            })
        case "column":
            return import('./../ud-column.jsx').then(({ default: UdColumn }) => {
                return <UdColumn {...component} key={component.id} history={history} />;
            })
        case "counter":
            return import('./../ud-counter.jsx').then(({ default: UdCounter }) => {
                return <UdCounter {...component} key={component.id}/>;
            })
        case "datetime":
            return import('./../basics/datetime.jsx').then(({ default: DateTime }) => {
                return <DateTime {...component} key={component.id}/>;
            })
        case "element":
            return import('./../ud-element.jsx').then(({ default: UdElement }) => {
                return <UdElement {...component} key={component.id} history={history} />;
            })
        case "error":
            return import('./../error-card.jsx').then(({ default: ErrorCard }) => {
                return <ErrorCard {...component} key={component.id}/>;
            })
        case "link":
            return import('./../ud-link.jsx').then(({ default: UdLink }) => {
                return <UdLink {...component} key={component.id}/>;
            })
        case "grid":
            return import('./../ud-grid.jsx').then(({ default: UdGrid }) => {
                return <UdGrid {...component} key={component.id}/>;
            })
        case "rawHtml":
            return import('./../ud-html.jsx').then(({ default: UdHtml }) => {
                return <UdHtml {...component} key={component.id}/>;
            })
        case "input":
            return import('./../ud-input.jsx').then(({ default: UdInput }) => {
                return <UdInput {...component} key={component.id} history={history}/>;
            })
        case "Monitor":
            return import('./../ud-monitor.jsx').then(({ default: UdMonitor }) => {
                return <UdMonitor {...component} key={component.id}/>;
            })
        case "navbar":
            return import('./../ud-navbar.jsx').then(({ default: UdNavbar }) => {
                return <UdNavbar {...component} key={component.id}/>;
            })
        case "row":
            return import('./../ud-row.jsx').then(({ default: UdRow }) => {
                return <UdRow {...component} key={component.id} history={history}/>;
            })
        case "treeview":
            return import('./../ud-treeview.jsx').then(({ default: UDTreeView }) => {
                return <UDTreeView {...component} key={component.id} history={history}/>;
            })
        case "imageCarousel":
            return import('./../ud-image-carousel.jsx').then(({ default: UDImageCarousel }) => {
                return <UDImageCarousel {...component} key={component.id} history={history}/>;
            })
    }
}