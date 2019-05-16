import React from 'react';
import {Checkbox} from 'react-materialize';

export default class UDCheckbox extends React.Component {

    onChanged(e) {
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