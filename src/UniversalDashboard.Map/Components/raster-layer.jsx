import React from 'react';
import { TileLayer } from 'react-leaflet';
import BingLayer from './bing-layer';

export default class UDRasterLayer extends React.Component {
    render() {
        if (this.props.bing) {
            return <BingLayer bingkey={this.props.apiKey} type={this.props.mapType}  />
        } else {
            return <TileLayer url={this.props.tileServer} attribution={this.props.attribution} opacity={this.props.opacity} zIndex={this.props.zIndex}  />
        }
    }
}