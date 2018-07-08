import { constants } from '../constants.js';

var defaultState = {
    loadingPlugins: false,
    hasError: false,
    plugins: []
}

/*

plugin = {
  routes = [
    <Route ... />
  ],
  responseMiddleware = function (response) {  },
  components = [
    {
      type: '',
      component: null
    }
  ]

}

*/

const app = (state = defaultState, action) => {
    switch (action.type) {
      case constants.LOAD_PLUGINS:
        return {
            ...state,
            loadingPlugins: true,
            hasError: false
        };
      case constants.LOAD_PLUGINS_SUCCESS:
        return {
          ...state,
          loadingPlugins: false,
          hasError: false
        };
      case constants.ADD_PLUGIN:
        return {
            ...state,
            loadingPlugins: false,
            hasError: false,
            plugins: state.plugins.push(action.plugin)
          };
      default:
        return state
    }
  }
  export default app