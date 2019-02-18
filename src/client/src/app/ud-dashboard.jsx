import React from 'react';

import {
    Route,
    Redirect,
    Switch
} from 'react-router-dom'
import {getApiPath} from 'config';
import UdPage from './ud-page.jsx';

import {fetchGet} from './services/fetch-service.jsx';
import { HubConnectionBuilder, LogLevel } from '@aspnet/signalr';
import UdPageCycler  from './page-cycler';

import toaster from './services/toaster';
import UDDesigner from './ud-designer';

export default class UdDashboard extends React.Component {
    constructor() {
        super();

        this.state = {
            dashboard: null,
            hasError: false,
            error: null,
            pausePageCycle: false,
            redirectToLogin: false,
            loading: true,
            location: null,
            authenticated: false,
            sessionId: '',
            design: false
        }
    }

    connectWebSocket(sessionId) {

        let connection = new HubConnectionBuilder()
            .withUrl(getApiPath() + '/dashboardhub')
            .configureLogging(LogLevel.Information)
            .build();

        connection.on('reload', data => {
            window.location.reload(true);
        });
        
        connection.on('setState', (componentId, state) => {
            UniversalDashboard.publish(componentId, {
                type: "setState",
                state: state
            });
        });

        connection.on('showToast', (model) => {
            toaster.show(model);
        });

        connection.on('hideToast', (id) => {
            toaster.hide(id);
        });

        connection.on('requestState', (componentId, requestId) => {
            UniversalDashboard.publish(componentId, {
                type: "requestState",
                requestId: requestId
            });
        });

        connection.on('removeElement', (componentId) => {
            UniversalDashboard.publish(componentId, {
                type: "removeElement",
                componentId: componentId
            });
        });

        connection.on('clearElement', (componentId) => {
            UniversalDashboard.publish(componentId, {
                type: "clearElement",
                componentId: componentId
            });
        });

        connection.on('syncElement', (componentId) => {
            UniversalDashboard.publish(componentId, {
                type: "syncElement",
                componentId: componentId
            });
        });

        connection.on('addElement', (componentId, elements) => {

            if (componentId == null) return;

            UniversalDashboard.publish(componentId, {
                type: "addElement",
                componentId: componentId,
                elements: elements
            });
        });

        connection.on('showModal', (props) => {
            UniversalDashboard.publish("modal.open", props);
        });

        connection.on('closeModal', () => {
            UniversalDashboard.publish("modal.close", {});
        });

        connection.on('redirect', (url, newWindow) => {
            if (newWindow) {
                window.open(url);
            }
            else {
                window.location.href = url;
            }
        });

        UniversalDashboard.subscribe('element-event', function(e, data) {
            if (data.type === "requestStateResponse") {
                connection.invoke("requestStateResponse", data.requestId, data.state)
            }

            if (data.type === "clientEvent") {
                connection.invoke("clientEvent", data.eventId, data.eventName, data.eventData, this.state.location).catch(function(e) {
                    toaster.show({
                        message: e.message,
                        icon: 'fa fa-times-circle',
                        iconColor: '#FF0000'
                    });
                });
            }

            if (data.type === "unregisterEvent") {
                connection.invoke("unregisterEvent", data.eventId)
            }
        }.bind(this));

        var _this = this;
        connection.start().then(x => {
            _this.connection = connection;
            window.UniversalDashboard.webSocket = connection;
            connection.invoke("setSessionId", sessionId);
        });
    }

    componentWillMount() {
        this.loadData();
    }

    relayEvent(json) {
        var events = JSON.parse(json);

        events.map(function(event) {
            UniversalDashboard.publish(event.id, event);
        })
    }

    componentDidCatch(error, info) {
        this.setState({ hasError: true, error: error });
    }

    togglePausePageCycle() {
        this.setState({
            pausePageCycle: !this.state.pausePageCycle
        })
    }

    loadStylesheet(url) {
        var styles = document.createElement('link');
        styles.rel = 'stylesheet';
        styles.type = 'text/css';
        styles.media = 'screen';
        styles.href = url;
        document.getElementsByTagName('head')[0].appendChild(styles);
    }

    loadJavascript(url) {
        var jsElm = document.createElement("script");
        jsElm.type = "application/javascript";
        jsElm.src = url;
        document.body.appendChild(jsElm);
    }

    loadData() {
        fetchGet("/api/internal/dashboard", function(json) {

            var dashboard = json.dashboard;

            document.title = dashboard.title;

            if (dashboard.stylesheets)
                dashboard.stylesheets.map(this.loadStylesheet.bind(this));

            if (dashboard.scripts)
                dashboard.scripts.map(this.loadJavascript.bind(this));

            if (dashboard.geolocation) {
                this.getLocation();
            }

            this.connectWebSocket(json.sessionId);

            this.setState({
                dashboard: dashboard,
                loading: false,
                sessionId:  json.sessionId,
                authenticated: json.authenticated,
                design: dashboard.design
            });

        }.bind(this), this.props.history);
    }

    getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var name = "location";

                var positionJson = {
                    coords: {
                        accuracy: position.coords.accuracy,
                        altitude: position.coords.altitude,
                        altitudeAccuracy: position.coords.altitudeAccuracy,
                        heading: position.coords.heading,
                        latitude: position.coords.latitude,
                        longitude: position.coords.longitude,
                        speed: position.coords.speed
                    },
                    timestamp: new Date(position.timestamp).toJSON()
                }

                var value = JSON.stringify(positionJson);
                value = btoa(value);
                document.cookie = name + "=" + (value || "") + "; path=/";

                this.setState({
                    location: value
                })
            }.bind(this));
        } 
    }

    getDefaultHomePage(){
        return this.state.dashboard.pages.find(function(page){
            return page.defaultHomePage === true;
        });
    }

    redirectToHomePage() {

        var defaultHomePage = this.getDefaultHomePage();
        
        if(defaultHomePage == null){
            defaultHomePage = this.state.dashboard.pages[0];
        }

        if(defaultHomePage != null && defaultHomePage.url == null){
            return <Redirect to={window.baseUrl + `/${defaultHomePage.name.replace(/ /g,"-")}`}/>
        }
        else if (defaultHomePage.url != null && defaultHomePage.url.indexOf(":") === -1) {
            return <Redirect to={defaultHomePage.url}/>
        }
        else if (defaultHomePage.name == null) {
            return UniversalDashboard.renderComponent({
                type: 'error',
                message: 'Your first page needs to be a static page or a dynamic page without a variable in the URL.'
            }) 
        }
        else {
            return <Redirect to={window.baseUrl + `/${defaultHomePage.name.replace(/ /g,"-")}`}/>
        }
    }

    render() {
        if (this.state.hasError) {
            return UniversalDashboard.renderComponent({
                type: 'error',
                message: this.state.error.message,
                location: this.state.error.stackTrace
            }) 
        }

        if (this.state.loading) {
            return UniversalDashboard.renderComponent({
                type: 'loading'
            })
        }

        var dynamicPages = this.state.dashboard.pages.map(function(x) {
            if (!x.dynamic) return null;

            if (!x.url.startsWith("/")) {
                x.url = "/" + x.url;
            }

            return <Route path={window.baseUrl + x.url} render={props => (
                <UdPage id={x.id} dynamic={true} {...props} autoRefresh={x.autoRefresh} refreshInterval={x.refreshInterval} key={props.location.key}/>
            )} />
        })

        var staticPages = this.state.dashboard.pages.map(function(x) {
            if (x.dynamic) return null;

            return <Route exact path={window.baseUrl + '/' + x.name.replace(/ /g, "-")} render={props => (
                <UdPage dynamic={false} {...x} {...props} autoRefresh={x.autoRefresh} refreshInterval={x.refreshInterval} key={props.location.key}/>
            )} />
        })

        var modal = UniversalDashboard.renderComponent({ type:'modal' });

        var navbar = UniversalDashboard.renderComponent({ 
            type:'navbar',
            backgroundColor : this.state.dashboard.navBarColor,
            fontColor : this.state.dashboard.navBarFontColor,
            text : this.state.dashboard.title,
            link: this.state.dashboard.navbarLinks,
            logo: this.state.dashboard.navBarLogo,
            pages: this.state.dashboard.pages,
            togglePaused: this.togglePausePageCycle.bind(this), 
            showPauseToggle: this.state.dashboard.cyclePages,
            history: this.props.history,
            authenticated: this.state.authenticated,
            navigation: this.state.dashboard.navigation,
         });

         var footer = UniversalDashboard.renderComponent({
            type: 'footer',
            backgroundColor: this.state.dashboard.navBarColor,
            fontColor: this.state.dashboard.navBarFontColor,
            footer: this.state.dashboard.footer,
            demo: this.state.dashboard.demo
         })

        return [
                <header>{navbar}</header>,
                <main style={{background: this.state.dashboard.backgroundColor, color: this.state.dashboard.fontColor}}>
                    <Switch>
                        {staticPages}
                        {dynamicPages}
                        <Route exact path="/" render={this.redirectToHomePage.bind(this)} />
                    </Switch>
                </main>,
                modal,
                footer,
                <Route path="/" render={function (x) {
                    return <UdPageCycler history={x.history} pages={this.state.dashboard.pages} cyclePages={this.state.dashboard.cyclePages && !this.state.pausePageCycle} cyclePagesInterval={this.state.dashboard.cyclePagesInterval} />
                    }.bind(this)}/>,
                this.state.design ? <UDDesigner/> : <span/>
                ]
    }
}