import React from 'react';
import UdDashboard from './ud-dashboard.jsx'
import {
    BrowserRouter as Router,
    Route
} from 'react-router-dom'

export default class App extends React.Component {
    render () {
        var regex = new RegExp('^' + window.baseUrl + '(?!.*(\/login))(?!.*(\/license)).*$');

        return (<Router>
                <div className="ud-dashboard">
                    <Route path={regex} component={UdDashboard} />
                </div>
            </Router> )
  }
}
