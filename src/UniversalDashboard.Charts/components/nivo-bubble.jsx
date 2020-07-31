import React from 'react';
import { ResponsiveBubble, Bubble } from '@nivo/circle-packing';

export default class NivoBubble extends React.Component {
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
            return <div style={{height: this.props.height}}><ResponsiveBubble {...this.props} onClick={this.onClick.bind(this)}/></div>
       } else {
           return <Bubble {...this.props} onClick={this.onClick.bind(this)}/>
       }
    }
}