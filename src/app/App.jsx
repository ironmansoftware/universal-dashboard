import React from 'react';
import UdDashboard from './ud-dashboard.jsx'
import {
    BrowserRouter as Router,
    Route,
    Switch
} from 'react-router-dom'
import NotAuthorized from '../Components/framework/not-authorized.jsx';
import NotRunning from '../Components/framework/not-running.jsx';
import { Alert, AlertTitle } from "@mui/material";

export default class App extends React.Component {

    constructor() {
        super();

        this.state = {
            loading: true,
            loadingMessage: 'Loading framework...',
            hasError: false,
            error: null,
            errorInfo: null
        }
    }

    static getDerivedStateFromError(error) {
        return { hasError: true, error };
    }


    loadJavascript(url, onLoad) {
        var jsElm = document.createElement("script");
        jsElm.onload = onLoad;
        jsElm.type = "application/javascript";
        jsElm.src = url;
        document.body.appendChild(jsElm);
    }

    componentWillMount() {
        this.setState({
            loading: false
        })
    }

    componentDidCatch(error, errorInfo) {
        this.setState({
            error,
            errorInfo
        })
    }

    render() {

        if (this.state.error) {
            return <Alert variant="standard" severity="error">
                <AlertTitle>{`Error rendering dashboard`}</AlertTitle>
                <p>This error is not expected. Please contact Ironman Software support.</p>
                <p>{this.state.error && this.state.error.toString()}</p>
                {this.state.errorInfo.componentStack}
            </Alert>
        }

        if (this.state.loading) {
            return <div style={{ backgroundColor: '#FFFFFF' }} className="v-wrap">
            </div>
        }

        var pluginRoutes = UniversalDashboard.provideRoutes();

        return (<Router basename={window.baseUrl}>
            <div className="ud-dashboard">
                <Switch>
                    {pluginRoutes}
                    <Route path="/not-authorized" component={NotAuthorized} />
                    <Route path="/not-running" component={NotRunning} />
                    <Route path="/" component={UdDashboard} />
                </Switch>
            </div>
        </Router>)
    }
}
