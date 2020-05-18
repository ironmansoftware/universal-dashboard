import React from 'react';
import { Map, ScaleControl } from 'react-leaflet';
import { css } from 'glamor-jss'; 
import { isGuid } from './utils';
import 'leaflet/dist/leaflet.css';
import L from 'leaflet';
import min from 'lodash.min';
import max from 'lodash.max';

delete L.Icon.Default.prototype._getIconUrl;

L.Icon.Default.mergeOptions({
    iconRetinaUrl: require('leaflet/dist/images/marker-icon-2x.png'),
    iconUrl: require('leaflet/dist/images/marker-icon.png'),
    shadowUrl: require('leaflet/dist/images/marker-shadow.png')
});

export default class UDMap extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
       latitude: props.latitude,
       longitude: props.longitude,
       zoom: props.zoom,
       features: [],
       loading: true,
       bounds: null
    }
  }

  onIncomingEvent(eventName, event) {
      if (event.type === "setState") {
          this.setState({...event.state.attributes})
      }
      else if (event.type === "requestState") {
        UniversalDashboard.post(`/api/internal/component/element/sessionState/${event.requestId}`, {
          attributes: {
            bounds: this.map.leafletElement.getBounds(), 
            zoom: this.state.zoom,
            latitude: this.state.latitude,
            longitude: this.state.longitude
          }
        });
      }
  }

  onReportBounds(bounds) { 

     if ((this.props.latitude && this.props.longitude) || !bounds) {
          return;
     }

     if (bounds.getNorth) {
       try 
       {
          bounds = [
            [bounds.getNorth(), bounds.getEast()],
            [bounds.getSouth(), bounds.getWest()]
        ]
       }
       catch {
         return 
       }
     }

     const currentBounds = this.state.bounds;

     if (this.state.bounds) {
        const newBounds = [
          [max(currentBounds[0][0], bounds[0][0]), max(currentBounds[0][1], bounds[0][1])],
          [min(currentBounds[1][0], bounds[1][0]), min(currentBounds[1][1], bounds[1][1])]
        ]
        this.setState({
            bounds: newBounds
        })
     }
     else {
        this.setState({
          bounds
        })
     }
  }

  loadMapData() {
     UniversalDashboard.get("/api/internal/component/element/" + this.props.id, function(data) {

        if (data.error) {
          this.setState({
            error: data.error.message
          })
        } else {
          this.setState({
             features : data,
             loading: false
          })
        }

     }.bind(this))
  }

  componentWillMount() {
     this.loadMapData();
     this.className = css({ height: this.props.height, width: this.props.width });
     if (!isGuid(this.props.id)) {
      this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
     }
  }

  render() {

    if (this.state.error) {
      return <div>{this.state.error}</div>
    }

    if (this.state.loading) {
      return <div>Loading...</div>
    }

      const position = [this.state.latitude, this.state.longitude];

      var features = this.state.features.map(x => {
          x.onReportBounds = this.onReportBounds.bind(this);
          return UniversalDashboard.renderComponent(x);
      });

      if (this.props.scaleControlPosition !== 'none') {
        features.push(<ScaleControl position={this.props.scaleControlPosition} />);
      }

      
      var additionalProps = {
      }

      if (this.state.bounds) {
        additionalProps['bounds'] = this.state.bounds;
      }

      return [
        <style  dangerouslySetInnerHTML={{__html: `
          .leaflet-control-layers-toggle {
            background-image: url(${require('leaflet/dist/images/layers.png')});
            width: 36px;
            height: 36px;
          }

          .leaflet-retina .leaflet-control-layers-toggle {
            background-image: url(${require('leaflet/dist/images/layers-2x.png')});
            background-size: 26px 26px;
          }


          `}} />,
          <Map {...additionalProps} ref={x => this.map = x} className="markercluster-map" maxZoom={this.props.maxZoom} center={position} zoom={this.state.zoom} className={this.className} animate={this.props.animate}>
              {features}
          </Map>
      ]
  }
}