require('leaflet/dist/leaflet.css')
require('leaflet/dist/leaflet.js')

import UDMap from './map';
import {UDLayerControl, UDLayerControlBaseLayer, UDLayerControlOverlay} from './layer-control';
import UDMarker from './marker';
import UDVectorLayer from './vector-layer';
import UDRasterLayer from './raster-layer';
import UDFeatureGroup from './feature-group';
import UDHeatmapLayer from './heatmap-layer';
import UDClusterLayer from './cluster-layer';

UniversalDashboard.register("ud-map", UDMap);
UniversalDashboard.register("map-layer-control", UDLayerControl);
UniversalDashboard.register("map-base-layer", UDLayerControlBaseLayer);
UniversalDashboard.register("map-overlay", UDLayerControlOverlay);
UniversalDashboard.register("map-marker", UDMarker);
UniversalDashboard.register("map-vector-layer", UDVectorLayer);
UniversalDashboard.register("map-raster-layer", UDRasterLayer);
UniversalDashboard.register("map-feature-group", UDFeatureGroup);
UniversalDashboard.register("map-heatmap-layer", UDHeatmapLayer);
UniversalDashboard.register("map-cluster-layer", UDClusterLayer);