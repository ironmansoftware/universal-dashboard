import React from 'react';

export default class UdLink extends React.Component {


    onClick(e) {
        if (this.props.onClick == null) {
            return
        }

        e.preventDefault();

        UniversalDashboard.publish('element-event', {
            type: "clientEvent",
            eventId: this.props.onClick,
            eventName: 'onClick',
            eventData: ''
        });
    }

    render() {
        var target = this.props.openInNewWindow ? "_blank" : "_self";

        var style = {
            color: this.props.color
        }

        if (this.props.icon) {
            var icon = UniversalDashboard.renderComponent({type: 'icon', icon: this.props.icon});
            return <a href={this.props.url} target={target} className={this.props.className + " ud-link"} style={style} onClick={this.onClick.bind(this)} id={this.props.id}>
            {icon} {this.props.text}
            </a>
        }
        else {
            return <a href={this.props.url} target={target} className={this.props.className + " ud-link"} style={style} onClick={this.onClick.bind(this)} id={this.props.id}>{this.props.text}</a>
        }
    }
}