import React from 'react';
import { Line, ResponsiveLine } from '@nivo/line';

export default class NivoLine extends React.Component {
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
            return <div style={{height: this.props.height}}><ResponsiveLine {...this.props} onClick={this.onClick.bind(this)}/></div>
       } else {
           return <Line {...this.props} onClick={this.onClick.bind(this)}/>
       }
    }
}