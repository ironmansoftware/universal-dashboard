import React from 'react';

export default class UDDesigner extends React.Component {
    render() {
        return UniversalDashboard.renderComponent({
            ...this.props,
            type: 'ud-designer'
        });
    }
}