import React from 'react';

export default class UdIcon extends React.Component {
    render() {
        let iconClass = `fa fa-${this.props.icon}`;

        return <i className={iconClass} style={this.props.style}></i>;
    }
}