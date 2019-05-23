import React from 'react';
import {Button} from 'react-materialize';
import UdIcon from './ud-icon';

export default class UDButton extends React.Component {

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

    render() {

        var style = {
            backgroundColor: this.props.backgroundColor,
            color: this.props.fontColor
        }

        var icon = null; 
        if (this.props.icon) {
            icon = <UdIcon icon={this.props.icon} style={{marginRight: '5px'}}/>
        }

        return <Button 
                    className="ud-button"
                    onClick={this.onClick.bind(this)}
                    id={this.props.id}
                    flat={this.props.flat} 
                    disabled={this.props.disabled}
                    floating={this.props.floating} 
                    style={style}
                >
                    {icon}
                    {this.props.text}
                </Button>
    }
}