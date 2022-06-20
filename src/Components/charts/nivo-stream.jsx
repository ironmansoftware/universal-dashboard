import React from 'react';
import { Stream, ResponsiveStream } from '@nivo/stream';

export default class NivoStream extends React.Component {
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
            return <div style={{height: this.props.height}}><ResponsiveStream {...this.props} onClick={this.onClick.bind(this)}/></div>
       } else {
           return <Stream {...this.props} onClick={this.onClick.bind(this)}/>
       }
    }
}