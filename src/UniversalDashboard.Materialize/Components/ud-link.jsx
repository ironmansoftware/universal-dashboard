import React,{Suspense} from 'react';

const UdIconComponent = React.lazy(() => import('./ud-icon.jsx' /* webpackChunkName: "ud-icon" */))

export default class UdLink extends React.Component {
    render() {
        var target = this.props.openInNewWindow ? "_blank" : "_self";

        var style = {
            color: this.props.color
        }

        if (this.props.icon) {
            return <a href={this.props.url} target={target} className={this.props.className + " ud-link"} style={style}>
            <Suspense fallback={<div>Loading...</div>}>
                <UdIconComponent icon={this.props.icon}></UdIconComponent> {this.props.text}
            </Suspense>
            </a>
        }
        else {
            return <a href={this.props.url} target={target} className={this.props.className + " ud-link"} style={style}>{this.props.text}</a>
        }
    }
}