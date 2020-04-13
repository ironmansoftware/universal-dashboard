import "./public-path";
import "@babel/polyfill";
import React from "react";
import ReactDOM from "react-dom";
import "whatwg-fetch";
import Promise from "promise-polyfill";
import { UniversalDashboardService } from "./services/universal-dashboard-service.jsx";
import App from "./App";
import { getApiPath } from "config";

window.react = require("react");
window["reactdom"] = require("react-dom");
window["reactrouterdom"] = require("react-router-dom");
window["themeui"] = require("theme-ui");
window["themeuicolormodes"] = require("@theme-ui/color-modes");

// To add to window
if (!window.Promise) {
  window.Promise = Promise;
}

window.UniversalDashboard = UniversalDashboardService;
require("./component-registration");

const rootEl = document.getElementById("app");
const root = ReactDOM.createRoot(rootEl);
root.Render(<App />);

// render(<App/>, document.getElementById('app'));
