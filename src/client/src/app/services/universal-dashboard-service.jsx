import React from 'react';
import { fetchGet, fetchPost } from './fetch-service.jsx';
import { internalRenderComponent } from './render-service.jsx';
import LazyElement from './../basics/lazy-element.jsx';

export const UniversalDashboardService = {
    components: [],
    register: function(type, component) {
        var existingComponent = this.components.find(x => x.type === type);
        if (!existingComponent) this.components.push({
            type, 
            component
        });
    },
    get: fetchGet,
    post: fetchPost,
    subscribe: PubSub.subscribe,
    unsubsribe: PubSub.unsubscribe,
    publish: PubSub.publishSync,
    renderComponent: function(component, history, dynamicallyLoaded) {

        if (component == null) return <React.Fragment/>;

        if (Array.isArray(component)) {
            return component.map(x => this.renderComponent(x, history));
        }

        var existingComponent = this.components.find(x => x.type === component.type);
        if (existingComponent != null) {
            return React.createElement(existingComponent.component, {
                ...component,
                key: component.id, 
                history
            });
        } else if (component.isPlugin && !dynamicallyLoaded) {
            return <LazyElement component={component} key={component.id} history={history}/>
        }

        return internalRenderComponent(component, history);
    }
}