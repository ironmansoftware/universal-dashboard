import React from 'react';

export default class UdCounter extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-counter'
        });
    }
}