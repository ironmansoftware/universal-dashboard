import React from 'react';
import { TreeMap, ResponsiveTreeMap } from '@nivo/treemap';

export default class NivoTreemap extends React.Component {
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
            return <div style={{height: this.props.height}}><ResponsiveTreeMap {...this.props} onClick={this.onClick.bind(this)} /></div>
       } else {
           return <TreeMap {...this.props} onClick={this.onClick.bind(this)}/>
       }
    }
}