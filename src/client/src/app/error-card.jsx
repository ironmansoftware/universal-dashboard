import React from 'react';

export default class UDErrorCard extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-errorcard'
        });
    }
}
