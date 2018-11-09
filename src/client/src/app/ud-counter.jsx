import React from 'react';
import UdIcon from './ud-icon.jsx';
var numeral = require("numeral");
import {fetchGet} from './services/fetch-service.jsx';
import ReactInterval from 'react-interval';
import ErrorCard from './error-card.jsx';
import UdLink from './ud-link.jsx';
import TextSize from './basics/text-size.jsx';
import PubSub from 'pubsub-js';

export default class UdCounter extends React.Component {
    constructor() {
        super();

        this.state = {
            value: 0,
            errorMessage: "",
            hasError: false
        }
    }

    loadData() {
        if (!this.props.id || this.props.id === "") {
            return;
        }

        fetchGet(`/api/internal/component/element/${this.props.id}`,function(json){
            if (json.error) {
                this.setState({
                    hasError: true, 
                    errorMessage: json.error.message
                })
            } else {
                this.setState({
                    hasError: false,
                    value: json
                });
            }
        }.bind(this));
    }

    componentWillMount() {
        this.loadData();
        this.pubSubToken = PubSub.subscribe(this.props.id, this.onIncomingEvent.bind(this));
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "syncElement") {
            this.loadData();
        }
    }

    componentWillUnmount() {
        PubSub.unsubscribe(this.pubSubToken);
    }

    componentDidUpdate(prevProps) {
        if (prevProps.id !== this.props.id) {
            this.loadData();
        }
    }

    render() {
        if (this.state.hasError) {
            return [<ErrorCard message={this.state.errorMessage} title={this.props.title} id={this.props.id} key={this.props.id} />, <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>]
        }

        let icon = null;
        if (this.props.icon !== 'none') {
            var em = "6em";
            if (this.props.value == null) {
                em = "4em";
            }

            icon = <UdIcon icon={this.props.icon} style={{opacity: 0.05, float:'left', marginLeft: '70px', fontSize: em, position:'absolute', top: '20px', color: this.props.fontColor}}/>
        }

        var value = numeral(this.state.value).format(this.props.format);

        var content = <div className={`${this.props.textAlignment}-align`}>
            {icon}
            <TextSize size={this.props.textSize}>{value}</TextSize>
        </div>

        var actions = null 
        if (this.props.links) {
            var links = this.props.links.map(function(x, i) {
                return <UdLink {...x} key={x.url} />
            });
            actions = <div className="card-action">
                {links}
            </div>
        }

        return <div className="card ud-counter" id={this.props.id} style={{background: this.props.backgroundColor, color: this.props.fontColor}}>
                  <div className="card-content">
                    <span className="card-title">{this.props.title}</span>
                    {content}
                </div>
                {actions}
                <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>
            </div>
    }
}