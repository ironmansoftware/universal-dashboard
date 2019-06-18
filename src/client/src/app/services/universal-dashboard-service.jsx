import React from 'react';
import { fetchGet, fetchPost, fetchDelete, fetchPut, fetchPostRaw } from './fetch-service.jsx';
import { internalRenderComponent } from './render-service.jsx';
import LazyElement from './../basics/lazy-element.jsx';
import PubSub from 'pubsub-js';
import toaster from './toaster';

export const UniversalDashboardService = {
    components: [],
    plugins: [],
    registerPlugin: function(plugin) {
        this.plugins.push(plugin);
    },
    register: function(type, component) {
        var existingComponent = this.components.find(x => x.type === type);
        if (!existingComponent) this.components.push({
            type, 
            component
        });
    },
    design: false,
    get: fetchGet,
    post: fetchPost,
    postRaw: fetchPostRaw,
    put: fetchPut,
    delete: fetchDelete,
    subscribe: PubSub.subscribe,
    unsubscribe: PubSub.unsubscribe,
    publish: PubSub.publishSync,
    toaster: toaster,
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
    },
    provideDashboardComponents: function(state) {

        var components = [];

        this.plugins.forEach(x => {
            try 
            {
                var pluginComponents = x.provideDashboardComponents(state);

                if (pluginComponents == null) {
                    return;
                }

                if (Array.isArray(pluginComponents)) {
                    components = components.concat(pluginComponents);
                } else {
                    components.push(pluginComponents);
                }
            }
            catch 
            {

            }
        })

        return components;
    },
    provideRoutes: function() {
        return this.plugins.forEach(x => {
            try 
            {
                return x.provideRoutes();
            }
            catch 
            {

            }
        })
    },
    invokeMiddleware: function(method, url, history, response) {
        this.plugins.forEach(x => {
            try 
            {
                x.invokeMiddleware(method, url, history, response);
            }
            catch 
            {

            }
        })
    }
}