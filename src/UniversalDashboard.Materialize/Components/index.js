import TabContainer from './tabs';

import UDErrorCard from './error-card';
import UDLink from './ud-link';
import UdImageCarousel from './ud-image-carousel';
import UDIcon from './ud-icon';

import("font-awesome/css/font-awesome.min.css" /* webpackChunkName: "font-awesome" */);

UniversalDashboard.register("tab-container", TabContainer);
UniversalDashboard.register("image-carousel", UdImageCarousel);
UniversalDashboard.register("ud-errorcard", UDErrorCard);
UniversalDashboard.register("ud-icon", UDIcon);
UniversalDashboard.register("ud-link", UDLink);