import React from 'react';
import {Route} from 'react-router-dom';

export default class UDRoute extends React.Component {
    render() {

        let { url } = this.props;

        if (!url.startsWith("/")) {
            url = "/" + url;
        }

        return <Route exact={url === '/'} key={url} path={window.baseUrl + url} render={props => <UdPage {...props} {...this.props}/>} />
    }
}

class UdPage extends React.Component {

    constructor() {
        super();

        this.state = {
            components: [],
            hasError: false,
            errorMessage: '',
            loading: true
        }
    }

    componentDidCatch(error, info) {
        this.setState({ hasError: true, errorMessage: error.message });
      }

    componentWillMount() {
        this.loadData();
    }

    loadData() {
        if (!this.props.match) {
            return;
        }

        var queryParams = {};

        for (var k in this.props.match.params) {
            if (this.props.match.params.hasOwnProperty(k)) {
                queryParams[k] = this.props.match.params[k];
            }
        }

        var esc = encodeURIComponent;
        var query = Object.keys(queryParams)
            .map(k => esc(k) + '=' + esc(queryParams[k]))
            .join('&');
    
        UniversalDashboard.get(`/api/internal/component/element/${this.props.id}?${query}`, function(json){
            if (json.error) {
                this.setState({
                    errorMessage: json.error.message,
                    hasError: true,
                    loading: false
                })
            }
            else {
                this.setState({
                    components: json,
                    hasError: false,
                    loading: false
                });
            }
        }.bind(this));
    }

    render() {

        if (this.state.loading) return React.Fragment;

        let { components } = this.state;

        return components.map(x => {
            return UniversalDashboard.renderComponent(x, this.props.history)
        });
    }
}