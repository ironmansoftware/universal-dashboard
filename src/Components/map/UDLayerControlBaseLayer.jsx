import React from 'react';
import { LayersControl } from 'react-leaflet';
import { isGuid } from './utils';

export default class UDLayerControlBaseLayer extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            content: props.content
        }
    }

    componentWillMount() {
        if (!isGuid(this.props.id)) {
            this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
        }
    }

    onRemoveChild(id) {
        var content = this.state.content;
        if (!Array.isArray(content)) {
            content = [content];
        }

        content = content.filter(x => x.id !== id);

        this.setState({
            content
        })
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "removeElement") {
            this.props.onRemove(this.props.id);
        }

        if (event.type === "addElement") {
            var content = this.state.content;
            if (!Array.isArray(content)) {
                content = [content];
            }

            content = content.concat(event.elements);

            this.setState({
                content
            })
        }
    }

    render() {
        var content = this.state.content;
        if (!Array.isArray(content)) {
            content = [content];
        }

        return <LayersControl.BaseLayer {...this.props} >
            {content.map(x => {
                x.onRemove = this.onRemoveChild.bind(this);
                return UniversalDashboard.renderComponent(x);
            })}
        </LayersControl.BaseLayer>
    }
}