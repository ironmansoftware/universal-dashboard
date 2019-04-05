import React from 'react';

export default class UdGrid extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-grid'
        });
    }
}