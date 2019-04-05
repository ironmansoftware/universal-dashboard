import React from 'react';

export default class UdLink extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-link'
        })
    }
}