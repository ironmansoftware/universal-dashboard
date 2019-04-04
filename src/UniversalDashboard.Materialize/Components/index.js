import Materialize from "materialize-css";

import TabContainer from './tabs';
import UDChart from './ud-chart';
import UDCounter from './ud-counter';
import UDErrorCard from './error-card';
import UDGrid from './ud-grid';
import UDLink from './ud-link';
import UdImageCarousel from './ud-image-carousel';
import UDIcon from './ud-icon';
import UDNavbar from './ud-navbar';
import UDNavigation from './ud-navigation';
import UdFooter from './ud-footer';
import UdInput from './ud-input';
import UdInputField from './ud-input-field';
import UdMonitor from './ud-monitor';
import UDLoading from './ud-loading';

import("font-awesome/css/font-awesome.min.css" /* webpackChunkName: "font-awesome" */);

UniversalDashboard.register("ud-chart", UDChart);
UniversalDashboard.register("ud-counter", UDCounter);
UniversalDashboard.register("tab-container", TabContainer);
UniversalDashboard.register("image-carousel", UdImageCarousel);
UniversalDashboard.register("ud-errorcard", UDErrorCard);
UniversalDashboard.register("ud-grid", UDGrid);
UniversalDashboard.register("ud-footer", UdFooter);
UniversalDashboard.register("ud-icon", UDIcon);
UniversalDashboard.register("ud-link", UDLink);
UniversalDashboard.register("ud-monitor", UdMonitor);
UniversalDashboard.register("ud-navbar", UDNavbar);
UniversalDashboard.register("ud-udnavigation", UDNavigation);
UniversalDashboard.register("ud-input", UdInput);
UniversalDashboard.register("ud-input-field", UdInputField);
UniversalDashboard.register("ud-loading", UDLoading);