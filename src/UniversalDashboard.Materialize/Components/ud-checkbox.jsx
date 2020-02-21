/** @jsx jsx */
import React from 'react';
import {Checkbox} from 'react-materialize';
import { jsx } from '@theme-ui/core'

export default class UDCheckbox extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            checked: props.checked,
            hidden: false
        }
    }

    componentWillMount() {
        this.pubSubToken = PubSub.subscribe(this.props.id, this.onIncomingEvent.bind(this));
    }

    componentWillUnmount() {
        PubSub.unsubscribe(this.pubSubToken);
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "requestState") {
            UniversalDashboard.post(`/api/internal/component/element/sessionState/${event.requestId}`, {
                attributes: {
                    checked: this.state.checked
                }
            });
        } 
        else if (event.type === "setState") {
            this.setState({
                checked: event.state.attributes.checked,
                hidden: event.state.attributes.hidden
            });
        }
        else if (event.type === "clearElement") {
            this.setState({
                checked: false
            });
        }
        else if (event.type === "removeElement") {
            this.setState({
                hidden: true
            });
        }
    }

    onChanged(e) {

        this.setState({
            checked: e.target.checked
        });

        if (this.props.onChange == null) {
            return
        }

        var val = e.target.checked;

        UniversalDashboard.publish('element-event', {
            type: "clientEvent",
            eventId: this.props.onChange,
            eventName: 'onChange',
            eventData: val.toString()
        });
    }

    render() {

        if (this.state.hidden) {
            return null;
        }

        return <Checkbox 
        sx={{ variant: 'forms.checkbox' }}
                    checked={this.state.checked} 
                    label={this.props.label}
                    id={this.props.id}
                    filledIn={this.props.filledIn}
                    disabled={this.props.disabled}
                    onChange={this.onChanged.bind(this)} />
    }
}