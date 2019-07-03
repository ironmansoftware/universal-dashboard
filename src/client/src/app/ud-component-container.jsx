import React from 'react';
import toaster from './services/toaster';

export default class ComponentContainer extends React.Component {
    buildComponentProps(component) {
        component.publishEvent = function(eventId, eventData) {
            UniversalDashboard.publish('element-event', {
                type: "clientEvent",
                eventId: eventId,
                eventName: '',
                eventData: eventData
            });
        }
        component.renderComponent = UniversalDashboard.renderComponent;
        component.unregisterEndpoint = UniversalDashboard.unregisterEndpoint;
        component.showToast = toaster.show;
        component.showError = toaster.error;
        component.subscribeToIncomingEvents = function(id, callback) {
            this.pubSubToken = UniversalDashboard.subscribe(id, callback);
        }.bind(this);
    
        return component;
    }

    componentWillUnmount() {
        if (this.pubSubToken) {
            UniversalDashboard.unsubscribe(this.pubSubToken);
        }
    }

    render() {
        var component = this.buildComponentProps(this.props.component);

        return React.createElement(this.props.componentType, {
            ...component,
            key: component.id, 
            history
        });
    }
}