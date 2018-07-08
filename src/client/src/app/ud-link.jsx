import React from 'react';
import {Link} from 'react-router-dom';
import UdIcon from './ud-icon.jsx';

export default class UdLink extends React.Component {
    render() {
        var target = this.props.openInNewWindow ? "_blank" : "_self";

        var style = {
            color: this.props.color
        }

        if (this.props.icon) {
            return <a href={this.props.url} target={target} className={this.props.className + " ud-link"} style={style}><UdIcon icon={this.props.icon}></UdIcon> {this.props.text}</a>
        }
        else {
            return <a href={this.props.url} target={target} className={this.props.className + " ud-link"} style={style}>{this.props.text}</a>
        }
    }
}