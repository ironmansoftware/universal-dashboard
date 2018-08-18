require('./polyfills.js');
import React from 'react';
import {render} from 'react-dom';
import $ from "jquery";
import Materialize from "materialize-css"
import "highlight.js/styles/agate.css";
import "materialize-css/dist/css/materialize.min.css";
import "font-awesome/css/font-awesome.min.css";
import 'whatwg-fetch';
import Promise from 'promise-polyfill'; 
import thunk from 'redux-thunk';
import "babel-polyfill";

import './styles/site.css';
import { UniversalDashboardService } from './services/universal-dashboard-service.jsx';
import ConnectedApp from './App';

import { Provider } from 'react-redux'
import { createStore, applyMiddleware } from 'redux'
import app from './reducers'

// To add to window
if (!window.Promise) {
  window.Promise = Promise;
}

window.UniversalDashboard = UniversalDashboardService;

const store = createStore(app, applyMiddleware(thunk));

render(<Provider store={store}><div><ConnectedApp/></div></Provider>, document.getElementById('app'));