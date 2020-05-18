import React from 'react';
import { ResponsiveBar, Bar } from '@nivo/bar';

export default class NivoBar extends React.Component {
    onClick(e) {
        if (this.props.hasCallback) {
            UniversalDashboard.publish('element-event', {
                type: "clientEvent",
                eventId: this.props.id,
                eventName: 'onClick',
                eventData: JSON.stringify(e)
            });
        }
    }

    render() {
       if (this.props.responsive) {
            return <div style={{height: this.props.height}}><ResponsiveBar {...this.props} onClick={this.onClick.bind(this)}/></div>
       } else {
           return <Bar {...this.props} onClick={this.onClick.bind(this)}/>
       }
    }
}