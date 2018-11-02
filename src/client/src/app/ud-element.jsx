import React from 'react';
import PubSub from 'pubsub-js';
import UDElementContent from './ud-element-content.jsx'

export default class UdElement extends React.Component {
    constructor() {
        super();

        this.state = {
            hidden: false
        }
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
        if (event.type === "removeElement") {
            this.setState({
                hidden: true
            })
        }
    }

    componentDidUpdate() {
        if (this.state.hidden && this.pubSubToken != null) {
            PubSub.unsubscribe(this.pubSubToken);
        }
    }

    componentWillUnmount() {
        if (this.pubSubToken != null) {
            console.log(this.pubSubToken);
            PubSub.unsubscribe(this.pubSubToken);
        }
    }

    render() {   
        if (this.state.hidden) {
            return null;
        }
        return <UDElementContent {...this.props} />
    }
}

