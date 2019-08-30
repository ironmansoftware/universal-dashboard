import React from 'react';
var numeral = require("numeral");
import ReactInterval from 'react-interval';
import ErrorCard from './error-card.jsx';
import UdLink from './ud-link.jsx';
import TextSize from './text-size.jsx';

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

        UniversalDashboard.get(`/api/internal/component/element/${this.props.id}`,function(json){
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

    onClickEvent(id, hasOnClick){

        if (!hasOnClick)
        {
            return;
        }
        
        UniversalDashboard.publish("element-event", {
                type: "clientEvent",
                eventId: id + "onClick",
                eventName: "onClick",
                eventData: ""
            }
        ); 
    }
    
    componentWillMount() {
        this.loadData();
        this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "syncElement") {
            this.loadData();
        }
    }

    componentWillUnmount() {
        UniversalDashboard.unsubscribe(this.pubSubToken);
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

            icon = UniversalDashboard.renderComponent({type: 'icon', icon: this.props.icon, color: this.props.fontColor});
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

        return <div className="card ud-counter" id={this.props.id} style={{background: this.props.backgroundColor, color: this.props.fontColor, cursor: this.props.hasOnClick ? "pointer" : "default"}}>
                  <div className="card-content" onClick={this.onClickEvent.bind(this, this.props.id, this.props.hasOnClick)}>
                    <span className="card-title">{this.props.title}</span>
                    {content}
                </div>
                {actions}
                <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>
            </div>
    }
}
