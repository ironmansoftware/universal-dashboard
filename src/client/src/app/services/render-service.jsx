import React from 'react';
import UdCard from './../ud-card.jsx';
import UdChart from './../ud-chart.jsx';
import UdColumn from './../ud-column.jsx';
import UdCounter from './../ud-counter.jsx';
import UdElement from './../ud-element.jsx';
import UdGrid from './../ud-grid.jsx';
import UdHtml from './../ud-html.jsx';
import UdLink from './../ud-link.jsx';
import UdInput from './../ud-input.jsx';
import UdMonitor from './../ud-monitor.jsx';
import UdNavbar from './../ud-navbar.jsx';
import UdRow from './../ud-row.jsx';
import ErrorCard from './../error-card.jsx';
import DateTime from './../basics/datetime.jsx';

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
        case "link":
            return <UdLink {...component} key={component.id}/>;
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
    }
}