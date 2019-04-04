import React from 'react';

export default class Input extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-input'
        });
    }
}