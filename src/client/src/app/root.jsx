import React from 'react';

export default class Root extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'root'
        });
    }
}