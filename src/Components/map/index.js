require('leaflet/dist/leaflet.css')
require('leaflet/dist/leaflet.js')
import React from 'react';

const UDMap = React.lazy(() => import('./map'));
const UDLayerControl = React.lazy(() => import('./UDLayerControl'));
const UDLayerControlBaseLayer = React.lazy(() => import('./UDLayerControlBaseLayer'));
const UDLayerControlOverlay = React.lazy(() => import('./UDLayerControlOverlay'));
const UDMarker = React.lazy(() => import('./marker'));
const UDVectorLayer = React.lazy(() => import('./vector-layer'));
const UDRasterLayer = React.lazy(() => import('./raster-layer'));
const UDFeatureGroup = React.lazy(() => import('./feature-group'));
const UDHeatmapLayer = React.lazy(() => import('./heatmap-layer'));
const UDClusterLayer = React.lazy(() => import('./cluster-layer'));

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