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
        var existingComponent = this.components.find(x => x.type === component.type);
        if (existingComponent != null) {
            return React.createElement(existingComponent.component, {
                ...component.properties,
                key: component.id, 
                history
            });
        } else if (component.properties.isPlugin && !dynamicallyLoaded) {
            return <LazyElement component={component} key={component.id} history={history}/>
        }
        
        return internalRenderComponent(component, history);
    }
}