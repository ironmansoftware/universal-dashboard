import React from 'react';

import UDIcon from './ud-icon.jsx';

export default class UdLink extends React.Component {
    render() {
        var target = this.props.openInNewWindow ? "_blank" : "_self";

        var style = {
            color: this.props.color
        }

        if (this.props.icon) {
            return <a href={this.props.url} target={target} className={this.props.className + " ud-link"} style={style}>
                <UDIcon icon={this.props.icon}></UDIcon> {this.props.text}
            </a>
        }
        else {
            return <a href={this.props.url} target={target} className={this.props.className + " ud-link"} style={style}>{this.props.text}</a>
        }
    }
}