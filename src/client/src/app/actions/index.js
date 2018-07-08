import { constants } from '../constants.js';
import { UniversalDashboardService } from './../services/universal-dashboard-service.jsx';

export const actions = {
    loadPlugins,
    addPlugin
}

function addPlugin(plugin) {
    return dispatch => {
        dispatch({
            type: constants.ADD_PLUGIN,
            plugin
        });
    };
}

function loadPlugins() {
    return dispatch => {
        dispatch(request());
        UniversalDashboardService.loadPlugins(success());
    };

    function request() { return { type: constants.LOAD_PLUGINS } }

    function success() { return { type: constants.LOAD_PLUGINS_SUCCESS } }

    function failure(error) { return { type: constants.LOAD_PLUGINS_ERROR, error } }
}