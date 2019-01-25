import React from 'react';
import {getApiPath} from 'config'
import renderComponent from './../services/render-service.jsx';

export default class LazyElement extends React.Component {
    constructor() {
        super();

        this.state = {
            loading: true
        }
    }
    componentWillMount() {
        $.getScript(getApiPath() + "/api/internal/javascript/" + this.props.component.properties.assetId, function() {
            this.setState({loading:false})
        }.bind(this));
    }

    render() {
        if (this.state.loading) {
            return <div></div>;
        }
        return renderComponent(this.props.component, this.props.history, true);
    }
}
