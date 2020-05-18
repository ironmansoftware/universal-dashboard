import React from 'react';
import {getApiPath} from './../config.jsx'
import renderComponent from './../services/render-service.jsx';

export default class LazyElement extends React.Component {
    constructor() {
        super();

        this.state = {
            loading: true,
            error: ""
        }
    }
    componentWillMount() {

        if (this.props.component.type === 'error')
        {
            return;
        }

        var script = document.createElement('script');
        script.onload = function() {
            this.setState({loading:false});
        }.bind(this)
        script.src = getApiPath() + "/api/internal/javascript/" + this.props.component.assetId;
        document.head.appendChild(script); 
    }

    componentDidCatch(e) {
        this.setState({
            error: e
        })
    }

    render() {
        if (this.state.loading) {
            return <div></div>;
        }

        if (this.props.component.type === 'error')
        {
            return <div>{this.props.component.message}</div>
        }

        if (this.state.error !== "") {
            return renderComponent({
                type: 'error', 
                message: `There was an error rendering component of type ${this.props.component.type}. ${this.state.error}`
            });
        }

        var element = renderComponent(this.props.component, this.props.history, true);

        if (element == null) {
            return renderComponent({
                type: 'error', 
                message: `Component not registered: ${this.props.component.type}`
            });
        }

        return element;
    }
}
