import React from 'react';
import { Popup } from 'react-leaflet';

export default class UDPopup extends React.Component {
    render() {

        var content = null;
        if (Array.isArray(this.props.content)) {
            content = this.props.content.map(x => UniversalDashboard.renderComponent(x));
        } else {
            content = UniversalDashboard.renderComponent(this.props.content);
        }

        var position = null;
        if (this.props.latitude && this.props.longitude) {
            position = [this.props.latitude, this.props.longitude];
        }
        
        return <Popup position={position} maxWidth={this.props.maxWidth} minWidth={this.props.minWidth}>
            {content}
        </Popup>
    }
}