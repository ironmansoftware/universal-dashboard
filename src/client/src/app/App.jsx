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
            loading: false
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
        this.showLoader = true;
        this.loadJavascript(getApiPath() + "/api/internal/javascript/framework", function() {
            this.showLoader = false;
            this.setState({
                loading: false
            })
        }.bind(this))

        setTimeout(function(){if(this.showLoader){this.setState({loading: true})}}.bind(this), 750);
    }

    render () {
        var regex = new RegExp('^' + window.baseUrl + '(?!.*(\/login))(?!.*(\/license)).*$');

        if (this.state.loading) {
            return <div style={{paddingLeft: '48vw', paddingTop: '40vh', backgroundColor: '#0689B7'}}><Spinner name="folding-cube" style={{width: '100px', height: '100px', color: '#E8E8E8'}}/></div>
        }

        return (<Router>
                <div className="ud-dashboard">
                    <Route path={regex} component={UdDashboard} />
                </div>
            </Router> )
  }
}
