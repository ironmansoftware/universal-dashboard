import React from 'react';
import { Marker, Popup } from 'react-leaflet';
import UDPopup from './popup';
import L from 'leaflet';
import { isGuid } from './utils';

export default class UDMarker extends React.Component {

    componentWillMount() {
        if (!isGuid(this.props.id)) {
            this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
        }
    }

    componentDidMount() {
        if (this.props.onReportBounds) {
            this.props.onReportBounds(
                [
                    [this.props.latitude, this.props.longitude],
                    [this.props.latitude, this.props.longitude]
                ]
            )
        }
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "removeElement") {
            this.props.onRemove(event.componentId);
        }
    }

    render() {

        var icon = null;
        if (this.props.icon) {

            var options = {
                iconUrl: this.props.icon.url
            }

            if (this.props.icon.width && this.props.icon.height) {
                options['iconSize'] = [this.props.icon.width, this.props.icon.height]
            }

            if (this.props.icon.anchorX && this.props.icon.anchorY) {
                options['iconAnchor'] = [this.props.icon.anchorX, this.props.icon.anchorY]
            }

            if (this.props.icon.popupAchorX && this.props.icon.popupAchorY) {
                options['popupAnchor'] = [this.props.icon.popupAchorX, this.props.icon.popupAchorY]
            }

            icon = L.icon(options);
        } else {
            icon = L.icon({
                iconRetinaUrl: require('leaflet/dist/images/marker-icon-2x.png'),
                iconUrl: require('leaflet/dist/images/marker-icon.png'),
                shadowUrl: require('leaflet/dist/images/marker-shadow.png')
            });
        }
    
        var position = [this.props.latitude, this.props.longitude];

        var popup = null;
        if (this.props.popup) {
            popup = <UDPopup {...this.props.popup} latitude={this.props.latitude} longitude={this.props.longitude} />
        }

        return <Marker position={position} icon={icon} ref={x => this.marker = x}>{popup}</Marker>
    }
}