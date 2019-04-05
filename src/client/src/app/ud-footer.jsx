import React from 'react';

export default class UdFooter extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-footer'
        });
    }
}