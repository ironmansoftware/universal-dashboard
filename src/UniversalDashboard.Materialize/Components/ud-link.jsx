import React,{Suspense} from 'react';

export default class UdLink extends React.Component {
    render() {
        var target = this.props.openInNewWindow ? "_blank" : "_self";

        var style = {
            color: this.props.color
        }

        if (this.props.icon) {
            var icon = UniversalDashboard.renderComponent({type: 'icon', icon: this.props.icon});
            return <a href={this.props.url} target={target} className={this.props.className + " ud-link"} style={style}>
            <Suspense fallback={<div>Loading...</div>}>
            {icon} {this.props.text}
            </Suspense>
            </a>
        }
        else {
            return <a href={this.props.url} target={target} className={this.props.className + " ud-link"} style={style}>{this.props.text}</a>
        }
    }
}