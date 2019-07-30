import React from 'react';
import {Checkbox} from 'react-materialize';

export default class UDCheckbox extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            checked: props.checked
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
        return <Checkbox 
                    checked={this.props.checked} 
                    label={this.props.label}
                    id={this.props.id}
                    filledIn={this.props.filledIn}
                    disabled={this.props.disabled}
                    onChange={this.onChanged.bind(this)} />
    }
}