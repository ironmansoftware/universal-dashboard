import React from 'react';
import {Col} from 'react-materialize';
import ErrorCard from './error-card.jsx';
import ReactInterval from 'react-interval';

export default class UdColumn extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            hasError: false,
            errorMessage: "",
            components: props.components
        }
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "syncElement") {
            this.loadData();
        }
    }

    componentWillUnmount() {
        UniversalDasboard.unsubscribe(this.pubSubToken);
    }

    loadData(){
        UniversalDasboard.get(`/api/internal/component/element/${this.props.id}`,function(data){
                if (data.error) {
                    this.setState({
                        hasError: true, 
                        errorMessage: data.error.message
                    })
                    return;
                }

                this.setState({
                    components: data
                })
            }.bind(this));
    }

    componentWillMount() {
        if (!this.state.components || this.state.components.length == 0) {
            this.loadData();
            this.pubSubToken = UniversalDasboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
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

        if (this.state.components == null) {
            return <div/>
        }

        var components = this.state.components.map(function(comp) {
            return UniversalDasboard.renderComponent(comp, this.props.history);
        }.bind(this))

        return <Col s={12} l={this.props.size} key={this.props.id} className="ud-column">
                    {components}
                    <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>
                </Col>;
    }
}