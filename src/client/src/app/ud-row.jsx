import React from 'react';
import {Row} from 'react-materialize';
import renderComponent from './services/render-service.jsx';
import ErrorCard from './error-card.jsx';
import ReactInterval from 'react-interval';
import {fetchGet} from './services/fetch-service.jsx';
import PubSub from 'pubsub-js';

export default class UdRow extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            hasError: false,
            errorMessage: "",
            columns: props.columns
        }
    }
    
    componentWillMount() {
        this.pubSubToken = PubSub.subscribe(this.props.id, this.onIncomingEvent.bind(this));
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "syncElement") {
            this.loadData();
        }
    }
    
    loadData(){
        fetchGet(`/component/element/${this.props.id}`,function(data){
                if (data.error) {
                    this.setState({
                        hasError: true, 
                        errorMessage: data.error.message
                    })
                    return;
                }

                this.setState({
                    columns: data
                })
            }.bind(this));
    }

    componentWillMount() {
        if (!this.state.columns) {
            this.loadData();
            this.pubSubToken = PubSub.subscribe(this.props.id, this.onIncomingEvent.bind(this));
        }
    }

    componentDidCatch(error, info) {
        this.setState({ hasError: true, errorMessage: error.message });
    }

    render() {
        if (this.state.hasError) {
            return <ErrorCard message={this.state.message} />
        }

        if (this.props.error) {
            return <ErrorCard message={this.props.error.message} />
        }

        if (this.state.columns == null) {
            return <div/>
        }

        var children = this.state.columns.map(function(x, i) {
            return renderComponent(x, this.props.history);
        }.bind(this));

        return <Row key={this.props.id} className="ud-row">
                    {children}
                    <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>
                </Row>;
    }
}