import React from 'react';

export default class UdIcon extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'icon'
        });
    }
}