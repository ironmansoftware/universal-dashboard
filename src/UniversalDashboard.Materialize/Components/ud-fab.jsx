import React from 'react';
import {Button} from 'react-materialize';
import UdIcon from './ud-icon';
import {css} from 'glamor-jss';

export default class UDFab extends React.Component {

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

        var colors = css({
            backgroundColor: this.props.backgroundColor,
            ':hover': {
                backgroundColor: this.props.backgroundColor
            },
            color: this.props.color
        });

        var icon = null; 
        if (this.props.icon) {
            icon = <UdIcon icon={this.props.icon}/>
        }

        var children = this.props.content.map(x => <UDFabButton {...x} />);

        return <Button 
                    floating
                    fab={{direction: this.props.expandDirection}}
                    className={"ud-fab " + colors}
                    onClick={this.onClick.bind(this)}
                    id={this.props.id}
                    floating
                    large={this.props.size === "large"}
                    icon={icon}
                >
                    {children}
                </Button>
    }
}

class UDFabButton extends React.Component {
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
            color: this.props.color
        }

        var icon = null; 
        if (this.props.icon) {
            icon = <UdIcon icon={this.props.icon}/>
        }

        return <Button 
                    className="ud-fab"
                    onClick={this.onClick.bind(this)}
                    id={this.props.id}
                    floating
                    large={this.props.size === "large"}
                    style={style}
                >            
                    {icon}
                </Button>
    }
}