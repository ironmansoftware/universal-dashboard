import React from 'react';
import { Calendar, ResponsiveCalendar } from '@nivo/calendar';

export default class NivoCalendar extends React.Component {
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
            return  <div style={{height: this.props.height}}><ResponsiveCalendar {...this.props} onClick={this.onClick.bind(this)}/></div>
       } else {
           return <Calendar {...this.props} onClick={this.onClick.bind(this)} />
       }
    }
}