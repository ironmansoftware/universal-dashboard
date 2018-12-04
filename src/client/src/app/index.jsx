import '@babel/polyfill';
import React from 'react';
import {render} from 'react-dom';
import $ from "jquery";
import Materialize from "materialize-css";
import 'whatwg-fetch';
import Promise from 'promise-polyfill'; 
import thunk from 'redux-thunk';
import { UniversalDashboardService } from './services/universal-dashboard-service.jsx';
import ConnectedApp from './App';
import { Provider } from 'react-redux'
import { createStore, applyMiddleware } from 'redux'
import app from './reducers'
import {getApiPath} from 'config';

// To add to window
if (!window.Promise) {
  window.Promise = Promise;
}

window.UniversalDashboard = UniversalDashboardService;

const store = createStore(app, applyMiddleware(thunk));

var styles = document.createElement('link');
styles.rel = 'stylesheet';
styles.type = 'text/css';
styles.media = 'screen';
styles.href = getApiPath() + "/api/internal/dashboard/theme";
document.getElementsByTagName('head')[0].appendChild(styles);

render(<Provider store={store}><ConnectedApp/></Provider>, document.getElementById('app'));