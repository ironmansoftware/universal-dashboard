import React from 'react';

export default class UdNavigation extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-navigation'
        });
    }
}