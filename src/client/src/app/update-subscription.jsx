import React from 'react';
import PubSub from 'pubsub-js';

export function withUpdateSubscription(WrappedComponent) {
    return class extends React.Component {
        constructor(props) {
            super(props);
    
            this.state = props;
        }
    
        isGuid(str) {
            if (str == null) { return false }
    
            if (str[0] === "{") 
            {
                str = str.substring(1, str.length - 1);
            }
            var regexGuid = /^(\{){0,1}[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}(\}){0,1}$/gi;
            var regexGuid = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
            return regexGuid.test(str);
        }
    
        componentWillMount() {
            if (!this.isGuid(this.props.id)) {
                this.pubSubToken = PubSub.subscribe(this.props.id, this.onIncomingEvent.bind(this));
            }
        }
    
        onIncomingEvent(eventName, event) {
            if (event.type === "update") {
                this.setState({
                    ...this.state,
                    ...event.props
                })
            }
        }
        render() {
            return <WrappedComponent {...this.state} />
        }
    }
}

