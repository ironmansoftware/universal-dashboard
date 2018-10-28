import React from 'react';
import { connect } from 'react-redux'
import { actions } from './actions';
const UdDashboard = React.lazy(() => import('./ud-dashboard.jsx'));

import {
    BrowserRouter as Router,
    Route
} from 'react-router-dom'

class App extends React.Component {

    componentWillMount() {
        window.UniversalDashboard.addPlugin = this.props.addPlugin;
        this.props.loadPlugins();
    }

    render () {
        window.UniversalDashboard.plugins = this.props.plugins;
        
        var routes = [];
        this.props.plugins.forEach(plugin => {
            if (plugin.routes != null) {
                routes.concat(plugin.routes)
            }
        })

        return (<Router>
            <div className="ud-dashboard">
                <Route path={/^(?!.*(\/login))(?!.*(\/license)).*$/} component={UdDashboard} />
                {routes}
                {/* <Route path="/login" component={Login} />
                <Route path="/signin" component={Login} /> */}
            </div>
        </Router> )
  }
}

const mapStateToProps = state => (state);

const mapDispatchToProps = dispatch => ({
    loadPlugins: () => dispatch(actions.loadPlugins()),
    addPlugin: plugin => dispatch(actions.addPlugin(plugin)),
  });

const ConnectedApp = connect(mapStateToProps, mapDispatchToProps)(App);
export default ConnectedApp;

