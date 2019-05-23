import './public-path';
import '@babel/polyfill';
import React from 'react';
import {render} from 'react-dom';
import $ from "jquery";
import 'whatwg-fetch';
import Promise from 'promise-polyfill'; 
import { UniversalDashboardService } from './services/universal-dashboard-service.jsx';
import App from './App';
import {getApiPath} from 'config';

// To add to window
if (!window.Promise) {
  window.Promise = Promise;
}

window.UniversalDashboard = UniversalDashboardService;

render(<App/>, document.getElementById('app'));