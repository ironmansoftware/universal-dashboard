import React from 'react';
import { HeatMap, ResponsiveHeatMap } from '@nivo/heatmap';

export default class NivoHeatmap extends React.Component {
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
            return <div style={{height: this.props.height}}><ResponsiveHeatMap {...this.props} onClick={this.onClick.bind(this)}/></div>
       } else {
           return <HeatMap {...this.props} onClick={this.onClick.bind(this)}/>
       }
    }
}