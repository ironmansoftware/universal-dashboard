import React from 'react';

export default class UdMonitor extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-monitor'
        });
    }
}