import React from 'react';
import UDMarker from './marker';
import MarkerClusterGroup from './Cluster';
import {isGuid} from './utils';

export default class UDClusterLayer extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            markers: props.markers
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
                markers: []
            })
        }

        if (event.type === 'addElement') {
            var markers = this.state.markers;

            var content = event.elements;
            if (!Array.isArray(content)) {
                content = [content]
            }

            markers = markers.concat(content);

            this.setState({
                markers
            })
        }
    }

    onRemoveMarker(id) {
        var markers = this.state.markers.filter(x => x.id !== id);

        this.setState({
            markers
        })
    }

    render() {
        return (
            <MarkerClusterGroup>
                {this.state.markers.map(x => <UDMarker {...x} onRemove={this.onRemoveMarker.bind(this)}/>)}
            </MarkerClusterGroup>
        )
    }
}

