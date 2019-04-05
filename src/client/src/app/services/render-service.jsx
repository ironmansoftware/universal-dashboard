import React,{Suspense} from 'react';
import UdNavbar from './../ud-navbar.jsx';

const UdChartComponent = React.lazy(() => import('./../ud-chart.jsx' /* webpackChunkName: "ud-chart" */))
const UdMonitorComponent = React.lazy(() => import('./../ud-monitor.jsx' /* webpackChunkName: "ud-monitor" */))
const UdLinkComponent = React.lazy(() => import('./../ud-link.jsx' /* webpackChunkName: "ud-link" */))
const UdErrorCardComponent = React.lazy(() => import('./../error-card.jsx' /* webpackChunkName: "ud-error-card" */))
const UdTreeViewComponent = React.lazy(() => import('./../ud-treeview.jsx' /* webpackChunkName: "ud-tree-view" */))
const UdInputComponent = React.lazy(() => import('./../ud-input.jsx' /* webpackChunkName: "ud-input" */))
const UdCounterComponent = React.lazy(() => import('./../ud-counter.jsx' /* webpackChunkName: "ud-counter" */))
const UdHtmlComponent = React.lazy(() => import('./../ud-html.jsx' /* webpackChunkName: "ud-html" */))
const UdGridComponent = React.lazy(() => import('./../ud-grid.jsx' /* webpackChunkName: "ud-grid" */))
const UdDateTimeComponent = React.lazy(() => import('./../basics/datetime.jsx' /* webpackChunkName: "ud-date-time" */))
const UdElementComponent = React.lazy(() => import('./../ud-element.jsx' /* webpackChunkName: "ud-element" */))
const UdTerminal = React.lazy(() => import( './../ud-terminal.jsx' /* webpackChunkName: "ud-terminal" */))
import UDGridLayout from './../ud-grid-layout';

export function internalRenderComponent(component, history) {
    if (!component) return null;

    switch(component.type) {

        case "grid-layout":
            return <UDGridLayout {...component} key={component.id}/>;

        case "chart":
            return <Suspense fallback={<div></div>}>
                <UdChartComponent {...component} key={component.id}/>
            </Suspense>

        case "counter":
            return <Suspense fallback={<div></div>}>
                        <UdCounterComponent {...component} key={component.id}/>
                    </Suspense>

        case "datetime":
            return <Suspense fallback={<div></div>}>
                        <UdDateTimeComponent {...component} key={component.id}/>
                    </Suspense>

        case "element":
            return <Suspense fallback={<div></div>}>
                        <UdElementComponent {...component} key={component.key} history={history}/>
                    </Suspense>

        case "error":
            return  <Suspense fallback={<div></div>}>
                <UdErrorCardComponent {...component} key={component.id}/>
            </Suspense>

        case "link":
            return <Suspense fallback={<div></div>}>
                        <UdLinkComponent {...component} key={component.id}/>
                    </Suspense>

        case "grid":
            return <Suspense fallback={<div></div>}>
                        <UdGridComponent {...component} key={component.id}/>
                    </Suspense>

        case "rawHtml":
            return <Suspense fallback={<div>Loading...</div>}>
                        <UdHtmlComponent {...component} key={component.id}/>
                    </Suspense>

        case "input":
            return <Suspense fallback={<div></div>}>
                <UdInputComponent {...component} key={component.id} history={history}/>
            </Suspense>

        case "Monitor":
            return  <Suspense fallback={<div></div>}>
                <UdMonitorComponent {...component} key={component.id}/>
            </Suspense>

        case "navbar":
            return <UdNavbar {...component} key={component.id}/>

        case "treeview":
            return <Suspense fallback={<div></div>}>
                <UdTreeViewComponent {...component} key={component.id} history={history}/>
            </Suspense>

        case "terminal":
            return <Suspense fallback={<div></div>}>
                <UdTerminal {...component} key={component.id}/>
            </Suspense>
    }

    return null;
}

export default function renderComponent(component, history, dynamicallyLoaded) {
    return window.UniversalDashboard.renderComponent(component, history, dynamicallyLoaded);
}