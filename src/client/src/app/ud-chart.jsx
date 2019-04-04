import React from 'react';

export default class UdChart extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-chart'
        });
    }
}