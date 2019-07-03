import React from 'react';
import {Checkbox} from 'react-materialize';

export default class UDCheckbox extends React.Component {

    onChanged(e) {
        if (this.props.onChange == null) {
            return
        }

        var val = e.target.checked;

        this.props.publishEvent(this.props.onChange, val.toString());
    }

    componentWillUnmount() {
        if (this.props.onChange) {
            this.props.unregisterEndpoint(this.props.onChange);
        }
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