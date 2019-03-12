import './public-path';
import '@babel/polyfill';
import React from 'react';
import {render} from 'react-dom';
import $ from "jquery";
import Materialize from "materialize-css";
import 'whatwg-fetch';
import Promise from 'promise-polyfill'; 
import { UniversalDashboardService } from './services/universal-dashboard-service.jsx';
import App from './App';
import {getApiPath} from 'config';
import 'typeface-roboto-condensed'
import 'typeface-roboto'

// To add to window
if (!window.Promise) {
  window.Promise = Promise;
}

window.UniversalDashboard = UniversalDashboardService;

var styles = document.createElement('link');
styles.rel = 'stylesheet';
styles.type = 'text/css';
styles.media = 'screen';
styles.href = getApiPath() + "/api/internal/dashboard/theme";
document.getElementsByTagName('head')[0].appendChild(styles);

render(<App/>, document.getElementById('app'));