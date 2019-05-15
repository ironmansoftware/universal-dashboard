import React from 'react';

export default class UDModal extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-modal'
        })
    }
}