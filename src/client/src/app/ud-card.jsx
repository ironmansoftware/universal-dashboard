import React from 'react';
import UdIcon from './ud-icon.jsx';
import UdLink from './ud-link.jsx';
var hljs = require("highlight.js")
import TextSize from './basics/text-size.jsx';
import renderComponent from './services/render-service.jsx';
import PubSub from 'pubsub-js';

export default class UdCard extends React.Component {
    componentDidMount() {
        hljs.initHighlightingOnLoad();
    }

    componentWillMount() {
        this.pubSubToken = PubSub.subscribe(this.props.id, this.onIncomingEvent.bind(this));
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "syncElement") {
            this.loadData();
        }
    }

    render() {

        var actions = null 
        if (this.props.links) {
            var links = this.props.links.map(function(x, i) {
                return <UdLink {...x} key={x.url} />
            });
            actions = <div className="card-action">
                {links}
            </div>
        }

        var highlight = null;
        if (this.props.language) {
            highlight = <pre className={this.props.language}>{this.props.text}</pre>
        } else if (this.props.text != null) {
            highlight = this.props.text.split('\r\n').map(function(line) {
                return [<span>{line}</span>,<br/>]
            })
        } else if (this.props.content != null) {
            highlight = this.props.content.map(function(x) {
                if (x.type != null) {
                    return renderComponent(x);
                } 
                return x;
            }.bind(this));
        }

        let icon = null;
        if (this.props.icon !== 'none') {
            var em = "6em";
            if (this.props.text == null && this.props.content == null) {
                em = "4em";
            }

            icon = <UdIcon icon={this.props.icon} style={{opacity: 0.05, float:'left', marginLeft: '70px', fontSize: em, position:'absolute', top: '20px', color: this.props.fontColor}}/>
        }

        highlight = <div className={`${this.props.textAlignment}-align`}>
                        {icon}
                        <TextSize size={this.props.textSize}>{highlight}</TextSize>
                    </div>

        return <div className="card ud-card" key={this.props.id} id={this.props.id} style={{background: this.props.backgroundColor, color: this.props.fontColor}}>
                    <div className="card-content" >
                        <span className="card-title">{this.props.title}</span>
                        {highlight}
                    </div>
                    {actions}
                </div>
    }
}

