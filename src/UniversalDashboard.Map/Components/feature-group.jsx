import React from 'react';
import { FeatureGroup } from 'react-leaflet';
import UDPopup from './popup';
import { isGuid } from './utils';

export default class UDFeatureGroup extends React.Component {

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
            this.props.onRemove(event.componentId);
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

    componentDidMount() {
        if (this.props.onReportBounds && this.featureGroup && this.featureGroup.leafletElement) {
            try {
                this.props.onReportBounds(this.featureGroup.leafletElement.getBounds());
            }
            catch {}
        }
    }

    render() {

        var popup = null;
        if (this.props.popup) {
            popup = <UDPopup {...this.props.popup} />
        }

        var content = null;
        if (Array.isArray(this.state.content)) {
            var self = this;
            content = this.state.content.map(x => {
                x.onRemove = self.onRemoveChild.bind(this);
                return UniversalDashboard.renderComponent(x);
            })
        } else {
            this.state.content.onRemove = this.onRemoveChild.bind(this);
            content = UniversalDashboard.renderComponent(this.state.content);
        }

        return <FeatureGroup id={this.props.id} ref={x => this.featureGroup = x}>{popup}{content}</FeatureGroup>
    }
}