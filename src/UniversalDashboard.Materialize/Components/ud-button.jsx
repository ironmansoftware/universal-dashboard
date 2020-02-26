/** @jsx jsx */
import React from 'react';
import {Button} from 'react-materialize';
import UdIcon from './ud-icon';
import {jsx} from 'theme-ui'
export default class UDButton extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            floating: this.props.floating,
            flat: this.props.flat,
            icon: this.props.icon,
            text: this.props.text,
            disabled: this.props.disabled,
            hidden: this.props.hidden,      
            style: this.props.style
        }
    }

    onClick() {
        if (this.props.onClick) {
            UniversalDashboard.publish('element-event', {
                type: "clientEvent",
                eventId: this.props.onClick,
                eventName: 'onChange',
                eventData: ''
            });
        }
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "requestState") {
            var data = {
                attributes: this.state
            }
            UniversalDashboard.post(`/api/internal/component/element/sessionState/${event.requestId}`, data);
        }
        else if (event.type === "setState") {
            this.setState(event.state.attributes);
        }
        else if (event.type === "clearElement") {
            this.setState({
                content: null
            });
        }
        else if (event.type === "removeElement") {
            this.setState({
                hidden:true
            });
        }
    }

    componentWillMount() {
        this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
    }
      
    componentWillUnmount() {
        UniversalDashboard.unsubscribe(this.pubSubToken);
    }

    render() {
        if(this.state.hidden) {
            return null;
        }

        var icon = null; 
        if (this.state.icon) {
            icon = <UdIcon icon={this.state.icon} style={{marginRight: this.state.floating || !this.state.text ? 'unset' : '5px'}}/>
        }

        return <Button 
                    className="ud-button"
                    onClick={this.onClick.bind(this)}
                    id={this.props.id}
                    flat={this.state.flat} 
                    disabled={this.state.disabled}
                    floating={this.state.floating} 
                    style={this.state.style}
                    sx={{bg: 'primary', color: 'text'}}
                >
                    {icon}
                    {this.state.text}
                </Button>
    }
}
