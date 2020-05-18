import React from 'react';
import { Circle, CircleMarker, Polygon, Polyline, Rectangle } from 'react-leaflet';
import { isGuid } from './utils';

export default class UDVectorLayer extends React.Component {

    onIncomingEvent(eventName, event) {
        if (event.type === "removeElement") {
            this.props.onRemove(this.props.id)
        }
    }

    componentWillMount() {
        if (!isGuid(this.props.id)) {
            this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
        }
    }

    componentDidMount() {
        if (this.props.onReportBounds && this.vector && this.vector.leafletElement) {
            try 
            {
                this.props.onReportBounds(this.vector.leafletElement.getBounds());
            }
            catch {}
        }
    }

    render() {
        


        if (this.props.circle) {
            var position = [this.props.latitude, this.props.longitude];

            var popup = null;
            if (this.props.popup) {
                popup = <UDPopup {...this.props.popup} />
                return <CircleMarker
                    center={position} 
                    radius={this.props.radius} 
                    color={this.props.color} 
                    fillColor={this.props.fillColor} 
                    fillOpacity={this.props.fillOpacity} 
                    weight={this.props.weight}
                    ref={x => this.vector = x}>
                        {popup}
                    </CircleMarker>
            }

            return <Circle
                    center={position} 
                    radius={this.props.radius} 
                    color={this.props.color} 
                    fillColor={this.props.fillColor} 
                    fillOpacity={this.props.fillOpacity} 
                    weight={this.props.weight}
                    ref={x => this.vector = x}/>
        }

        if (this.props.polyline) {
            return <Polyline 
                    positions={this.props.positions} 
                    color={this.props.color} 
                    fillColor={this.props.fillColor} 
                    fillOpacity={this.props.fillOpacity} 
                    weight={this.props.weight} 
                    ref={x => this.vector = x}/>
        }

        if (this.props.polygon) {
            return <Polygon 
                    positions={this.props.positions} 
                    color={this.props.color} 
                    fillColor={this.props.fillColor} 
                    fillOpacity={this.props.fillOpacity} 
                    weight={this.props.weight} 
                    ref={x => this.vector = x}/>
        }

        if (this.props.rectangle) {

            var bounds = [
                [
                    this.props.latitudeTopLeft,
                    this.props.longitudeTopLeft,
                ],
                [
                    this.props.latitudeBottomRight,
                    this.props.longitudeBottomRight,
                ]
            ]

            return <Rectangle 
                    bounds={bounds}
                    color={this.props.color} 
                    fillColor={this.props.fillColor} 
                    fillOpacity={this.props.fillOpacity} 
                    weight={this.props.weight} 
                    ref={x => this.vector = x}/>
        }

        
        return <div>Unknown type</div>
    }
}