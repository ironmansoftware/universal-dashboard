import React from 'react';
import renderComponent from './services/render-service.jsx';
import PubSub from 'pubsub-js';
import {fetchGet, fetchPost} from './services/fetch-service.jsx';
import {getApiPath} from 'config';
import ReactInterval from 'react-interval';
import ErrorCard from './error-card.jsx';

export default class UdElement extends React.Component {
    constructor() {
        super();

        this.state = {
            hidden: false
        }
    }

    isGuid(str) {
        if (str == null) { return false }

        if (str[0] === "{") 
        {
            str = str.substring(1, str.length - 1);
        }
        var regexGuid = /^(\{){0,1}[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}(\}){0,1}$/gi;
        var regexGuid = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
        return regexGuid.test(str);
    }

    componentWillMount() {
        if (!this.isGuid(this.props.id)) {
            this.pubSubToken = PubSub.subscribe(this.props.id, this.onIncomingEvent.bind(this));
        }
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "removeElement") {
            this.setState({
                hidden: true
            })
        }
    }

    componentDidUpdate() {
        if (this.state.hidden && this.pubSubToken != null) {
            PubSub.unsubscribe(this.pubSubToken);
        }
    }

    componentWillUnmount() {
        if (this.pubSubToken != null) {
            console.log(this.pubSubToken);
            PubSub.unsubscribe(this.pubSubToken);
        }
    }

    render() {   
        if (this.state.hidden) {
            return null;
        }
        return <UDElementContent {...this.props} />
    }
}

class UDElementContent extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            content : props.content,
            tag : props.tag,
            attributes: props.attributes,
            events: props.events,
            loading: true,
            hasError: false,
            errorMessage: ''
        }
    }

    loadData()
    { 
        fetchGet("/api/internal/component/element/" + this.props.id, function(data) {
            if (data.error) {
                this.setState({
                    hasError: true, 
                    errorMessage: data.error.message
                })
                return;
            }

            this.setState({
                content: data,
                loading: false
            });
        }.bind(this));
    }

    componentDidCatch(error, info) {
        this.setState({ hasError: true, errorMessage: error.message });
    }

    componentWillMount() {
        this.pubSubToken = PubSub.subscribe(this.props.id, this.onIncomingEvent.bind(this));
        if (this.props.hasCallback) {
            this.loadData();
        }
        else 
        {
            if (this.props.js) {
                $.getScript(getApiPath() + "/js/" + this.props.js, function() {
                    this.setState({
                        loading: false
                    })
                }.bind(this));
            }
            else {
                this.setState({
                    loading: false
                })
            }
        }
    }

    componentDidMount() {
        if (this.state.tag === 'input' && this.state.attributes != null && this.state.attributes["type"] === 'text') {
            Materialize.updateTextFields();
        }
        
        $('.collapsible').collapsible();

        if (this.state.tag === 'select') {
            $(this.refs.element).material_select(this.onUserEvent.bind(this));
        }

        if (this.props.onLoad) {
            eval(this.props.onLoad);
        }
    }

    componentDidUpdate() {
        if (this.state.tag === 'input' && this.state.attributes != null && this.state.attributes["type"] === 'text') {
            Materialize.updateTextFields();
        }
    }

    onTextboxChanged(e) {
        var val = e.target.value;
        this.state.attributes.value = val;

        this.setState({
            attributes : this.state.attributes
        });
    }

    onCheckboxChanged(e) {
        var val = e.target.value;
        val = e.target.checked;
        this.state.attributes.checked = val;

        this.setState({
            attributes : this.state.attributes
        });

        for(var i = 0; i < this.state.events.length; i++) {
            if (this.state.events[i].event === 'onChange') {

                var event = this.state.events[i];

                PubSub.publish('element-event', {
                    type: "clientEvent",
                    eventId: event.id,
                    eventName: 'onChange',
                    eventData: val
                });
            }
        }
    }

    componentWillUnmount() {
        if (this.state.events != null) {
            for(var i = 0; i < this.state.events.length; i++) {
                PubSub.publish('element-event', {
                    type: "unregisterEvent",
                    eventId: this.state.events[i].id
                });
            }
        }

        if (this.props.hasCallback) {
            PubSub.publish('element-event', {
                type: "unregisterEvent",
                eventId: this.props.id
            });
        }

        PubSub.unsubscribe(this.pubSubToken);
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "setState") {
            this.setState(event.state);
        }
        else if (event.type === "requestState") {
            fetchPost(`/api/internal/component/element/sessionState/${event.requestId}`, this.state);
        } else if (event.type === "removeElement") {
            this.setState({
                hidden: true
            })
        } else if (event.type === "addElement") {

            var content = this.state.content;
            if (content == null) {
                content = []
            }

            content = content.concat(event.elements);

            this.setState({
                content
            })
        } else if (event.type === "clearElement") {
            this.setState({
                content: null
            })
        } else if (event.type === "syncElement") {
            this.loadData();
        }
    }

    onUserEvent(event, e) {
        var eventName = null;
        var val = null;
        if (this.state.tag === 'select') {
            val = this.refs.element[this.refs.element.selectedIndex].value
            for(var i = 0; i < this.state.events.length; i++) {
                if (this.state.events[i].event === 'onChange') {
                    event = this.state.events[i];
                }
            }
            eventName = 'onChange'
        }
        else {
            eventName = event.event;
            val = e.target.value;
            if (val != null && val.checked != null) {
                val = e.target.checked;
            }
        }

        this.state.attributes.value = val;
        this.setState(this.state);

        PubSub.publish('element-event', {
            type: "clientEvent",
            eventId: event.id,
            eventName: eventName,
            eventData: val
        });
    }

    render() {
        if (this.state.hidden) {
            return null;
        }

        if (this.state.hasError) {
            return <ErrorCard message={this.state.errorMessage} />
        }

        if (this.props.error) {
            return <ErrorCard message={this.props.error.message} />
        }

        if (this.state.loading) {
            return <div></div>
        }

        if (this.props.js) {
            return React.createElement(eval(this.props.moduleName + "." + this.props.componentName), this.props.props);
        }

        var children = null;
        
        if (this.state.content) {
            children = this.state.content.map(function(x) {
                if (x.type != null) {
                    return renderComponent(x, this.props.history);
                } 
                return x;
            }.bind(this));
        }

        var attributes = this.state.attributes;

        if (attributes == null) {
            attributes = {}
        }

        if (attributes.id == null) {
            attributes.id = this.props.id;
        }

        if (this.state.events != null && this.state.events.map) {
            this.state.events.map(function(event) {
                attributes[event.event] = function(e) {
                    this.onUserEvent(event, e);
                }.bind(this);
                return null;
            }.bind(this));
        }

        if (this.state.tag === "input") {
            if (attributes.type === "text") {
                attributes.onChange = this.onTextboxChanged.bind(this);
            }

            if (attributes.type === "checkbox") {
                attributes.onChange = this.onCheckboxChanged.bind(this);
            }
        }

        if (this.state.tag === "textarea") {
            attributes.onChange = this.onTextboxChanged.bind(this);
        }

        attributes.ref = 'element';
        attributes.key = this.props.key;

        this.element = React.createElement(this.state.tag, attributes, children);

    return [this.element, 
            <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>];
    }
}