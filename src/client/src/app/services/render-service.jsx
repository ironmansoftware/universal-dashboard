import React,{Suspense} from 'react';
import UdColumn from './../ud-column.jsx';
import UdNavbar from './../ud-navbar.jsx';
import UdRow from './../ud-row.jsx';


const UdCardComponent = React.lazy(() => import('./../ud-card.jsx' /* webpackChunkName: "ud-card" */))
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
const UdImageCarouselComponent = React.lazy(() => import( './../ud-image-carousel.jsx' /* webpackChunkName: "ud-image-carousel" */))
        


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
            return <Suspense fallback={<div>Loading...</div>}>
                <UdCardComponent {...component} key={component.id}/>
            </Suspense>

        case "chart":
            return <Suspense fallback={<div>Loading...</div>}>
                <UdChartComponent {...component} key={component.id}/>
            </Suspense>
            
        case "column":
            return <UdColumn {...component} key={component.id} history={history} />

        case "counter":
            return <Suspense fallback={<div>Loading...</div>}>
                        <UdCounterComponent {...component} key={component.id}/>
                    </Suspense>

        case "datetime":
            return <Suspense fallback={<div>Loading...</div>}>
                        <UdDateTimeComponent {...component} key={component.id}/>
                    </Suspense>

        case "element":
            return <Suspense fallback={<div>Loading...</div>}>
                        <UdElementComponent {...component} key={component.id} history={history}/>
                    </Suspense>

        case "error":
            return  <Suspense fallback={<div>Loading...</div>}>
                <UdErrorCardComponent {...component} key={component.id}/>
            </Suspense>

        case "link":
            return <Suspense fallback={<div>Loading...</div>}>
                        <UdLinkComponent {...component} key={component.id}/>
                    </Suspense>

        case "grid":
            return <Suspense fallback={<div>Loading...</div>}>
                        <UdGridComponent {...component} key={component.id}/>
                    </Suspense>

        case "rawHtml":
            return <Suspense fallback={<div>Loading...</div>}>
                        <UdHtmlComponent {...component} key={component.id}/>
                    </Suspense>

        case "input":
            return <Suspense fallback={<div>Loading...</div>}>
                <UdInputComponent {...component} key={component.id} history={history}/>
            </Suspense>

        case "Monitor":
            return  <Suspense fallback={<div>Loading...</div>}>
                <UdMonitorComponent {...component} key={component.id}/>
            </Suspense>

        case "navbar":
            return <UdNavbar {...component} key={component.id}/>

        case "row":
            return <UdRow {...component} key={component.id} history={history}/>

        case "treeview":
            return <Suspense fallback={<div>Loading...</div>}>
                <UdTreeViewComponent {...component} key={component.id} history={history}/>
            </Suspense>
            
        case "imageCarousel":
            return <Suspense fallback={<div>Loading...</div>}>
                <UdImageCarouselComponent {...component} key={component.id}/>
            </Suspense>
    }
}