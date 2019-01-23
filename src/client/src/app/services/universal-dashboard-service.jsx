import React from 'react';
import { fetchGet, fetchPost } from './fetch-service.jsx';
import { internalRenderComponent } from './render-service.jsx';

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
    renderComponent: function(component, history) {
        var existingComponent = this.components.find(x => x.type === component.type);
        if (existingComponent) {
            return React.createElement(existingComponent.component, {
                ...component,
                key: component.id, 
                history
            });
        }
        
        return internalRenderComponent(component, history);
    }
}