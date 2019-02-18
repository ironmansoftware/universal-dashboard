import React from 'react';
import ReactInterval from 'react-interval';

export default class UdPage extends React.Component {

    constructor() {
        super();

        this.state = {
            components: [],
            hasError: false,
            errorMessage: ""
        }
    }

    componentDidCatch(error, info) {
        this.setState({ hasError: true, errorMessage: error.message });
      }

    componentWillMount() {
        this.loadData();
    }

    loadData() {
        if (this.props.dynamic) {
            this.loadDynamicPage();
        } else {
            this.loadStaticPage();
        }
    }

    loadStaticPage() {
        UniversalDashboard.get(`/api/internal/dashboard/page/${this.props.name}`, function(json){
            if (json.error) {
                this.setState({
                    errorMessage: json.error.message,
                    hasError: true
                })
            }
            else  {
                this.setState({
                    components: json.components,
                    hasError: false
                });
            }
        }.bind(this));
    }
    
    loadDynamicPage() {
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
                    hasError: true
                })
            }
            else {
                this.setState({
                    components: json,
                    hasError: false
                });
            }
        }.bind(this));
    }

    render() {
        if (this.state.hasError) {
            return UniversalDashboard.renderComponent({
                type: 'error',
                message: this.state.errorMessage,
                title: 'An error occurred on this page',
                id: this.props.id
            })
        }

        if (!this.state.components || !this.state.components.map) {
            var parameterName = this.props.dynamic ? "Endpoint" : "Content";
            return UniversalDashboard.renderComponent({
                type: 'error',
                message: `There was an error with your ${parameterName} for this page. You need to return at least one component from the ${parameterName}.`
            })
        } 

        var childComponents = this.state.components.map(function(x) {
            return UniversalDashboard.renderComponent(x, this.props.history);
        }.bind(this));

        return <div>{childComponents}
        <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>
        </div>;
    }
}