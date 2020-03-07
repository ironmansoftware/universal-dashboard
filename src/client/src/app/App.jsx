import React from 'react';
import UdDashboard from './ud-dashboard.jsx'
import {
    BrowserRouter as Router,
    Route
} from 'react-router-dom'
import {getApiPath} from 'config';
import Spinner from 'react-spinkit';

export default class App extends React.Component {

    constructor() {
        super();

        this.state = {
            loading: true,
            loadingMessage: 'Loading framework...'
        }
    }

    loadJavascript(url, onLoad) {
        var jsElm = document.createElement("script");
        jsElm.onload = onLoad;
        jsElm.type = "application/javascript";
        jsElm.src = url;
        document.body.appendChild(jsElm);
    }

    componentWillMount() {
        this.loadJavascript(getApiPath() + "/api/internal/javascript/framework", function() {

            // var styles = document.createElement('link');
            // styles.rel = 'stylesheet';
            // styles.type = 'text/css';
            // styles.media = 'screen';
            // styles.href = getApiPath() + "/api/internal/dashboard/theme";
            // document.getElementsByTagName('head')[0].appendChild(styles);

            this.setState({
                loadingMessage: "Loading plugins..."
            })

            this.loadJavascript(getApiPath() + "/api/internal/javascript/plugin", function() {
                this.setState({
                    loading: false
                })
            }.bind(this));
        }.bind(this))
    }

    render () {
        var regex = new RegExp('^' + window.baseUrl + '(?!.*(\/login))(?!.*(\/license)).*$');

        if (this.state.loading) {
            return <div style={{backgroundColor: '#FFFFFF'}} className="v-wrap">
                        <article className="v-box">
                            <Spinner name="folding-cube" style={{width: '150px', height: '150px', color: '#0689B7'}}/>
                        </article>
                        
                    </div>
        }

        var pluginRoutes = UniversalDashboard.provideRoutes();

        return (<Router>
                <div className="ud-dashboard">
                    {pluginRoutes}
                    <Route path={regex} component={UdDashboard} />
                </div>
            </Router> )
  }
}
