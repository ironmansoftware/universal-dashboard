import React from 'react';
import HeatmapLayer from './HeatmapLayer.js';
import {isGuid} from './utils';

export default class UDHeatmap extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            points: props.points
        }
    } 

    componentWillMount() {
        if (!isGuid(this.props.id)) {
            this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
        }
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "removeElement") {
            this.props.onRemove(event.componentId);
        }

        if (event.type === "clearElement") {
            this.setState({
                points: []
            })
        }

        if (event.type === "addElement") {
            var points = this.state.points.concat(event.elements);

            this.setState({
                points
            })
        }
    }

    render() {
        return (
            <HeatmapLayer 
                points={this.state.points} 
                //fitBoundsOnLoad={this.props.fitBounds}
                //fitBoundsOnUpdate
                longitudeExtractor={m => m[1]}
                latitudeExtractor={m => m[0]}
                intensityExtractor={m => parseFloat(m[2])} 
                //max={this.props.maxIntensity}
                //radius={this.props.radius}
                maxZoom={this.props.maxZoom}
                minOpacity={this.props.minOpacity}
                //blur={this.props.blur}
                gradient={this.props.gradient}
                onReportBounds={this.props.onReportBounds}
                />
        )
    }
}