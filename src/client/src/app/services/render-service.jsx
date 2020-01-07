import React, { Suspense } from 'react';

const UdHtmlComponent = React.lazy(() => import('./../ud-html.jsx' /* webpackChunkName: "ud-html" */))
const UdDateTimeComponent = React.lazy(() => import('./../basics/datetime.jsx' /* webpackChunkName: "ud-date-time" */))
const UdElementComponent = React.lazy(() => import('./../ud-element.jsx' /* webpackChunkName: "ud-element" */))
const UdIcon = React.lazy(() => import('./../ud-icon.jsx' /* webpackChunkName: "ud-icon" */))

export function internalRenderComponent(component, history) {
    if (!component) return null;

    switch (component.type) {

        case "icon":
            return <Suspense fallback={null}><UdIcon {...component} key={component.id} /></Suspense>;

        case "datetime":
            return <Suspense fallback={null}>
                <UdDateTimeComponent {...component} key={component.id} />
            </Suspense>

        case "element":
            return <Suspense fallback={null}>
                <UdElementComponent {...component} key={component.key} history={history} />
            </Suspense>

        case "rawHtml":
            return <Suspense fallback={null}>
                <UdHtmlComponent {...component} key={component.id} />
            </Suspense>
    }

    return null;
}

export default function renderComponent(component, history, dynamicallyLoaded) {
    return window.UniversalDashboard.renderComponent(component, history, dynamicallyLoaded);
}