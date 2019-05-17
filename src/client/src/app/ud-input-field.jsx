import React from 'react';

export default class UdInputField extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-input-field'
        }, this.props.history);
    }
}