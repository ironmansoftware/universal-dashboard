import React from 'react';
import {getApiPath} from 'config'

export default class LazyElement extends React.Component {
    constructor() {
        super();

        this.state = {
            loading: true
        }
    }
    componentWillMount() {
        $.getScript(getApiPath() + "/api/internal/javascript/" + this.props.component.assetId, function() {
            this.setState({loading:false})
        }.bind(this));
    }

    render() {
        if (this.state.loading) {
            return <div></div>;
        }
        return UniversalDashboard.renderComponent(this.props.component, this.props.history, true);
    }
}
