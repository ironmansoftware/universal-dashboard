import React from 'react';

export default class Loading extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-loading'
        })
    }
}