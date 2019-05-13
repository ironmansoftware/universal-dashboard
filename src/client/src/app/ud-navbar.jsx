import React from 'react';

export default class UdNavbar extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-navbar'
        },
        this.props.history);
    }
}