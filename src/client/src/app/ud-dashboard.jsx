import React,{Suspense} from 'react';

import {
    Route,
    Redirect,
    Switch
} from 'react-router-dom'
import {getApiPath} from 'config';
import UdPage from './ud-page.jsx';
import UdNavbar from './ud-navbar.jsx';
import UdFooter from './ud-footer.jsx';
import {fetchGet} from './services/fetch-service.jsx';
import PubSub from 'pubsub-js';
import { HubConnectionBuilder, LogLevel } from '@aspnet/signalr';

const UdLoadingComponent = React.lazy(() => import('./ud-loading.jsx' /* webpackChunkName: "ud-loading" */))
const UdPageCyclerComponent = React.lazy(() => import('./page-cycler.jsx' /* webpackChunkName: "ud-page-cycler" */))
const UdModalComponent = React.lazy(() => import('./ud-modal.jsx' /* webpackChunkName: "ud-modal" */))
const UdErrorCardComponent = React.lazy(() => import('./error-card.jsx' /* webpackChunkName: "ud-error-card" */))

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
            PubSub.publish(componentId, {
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
            PubSub.publish(componentId, {
                type: "requestState",
                requestId: requestId
            });
        });

        connection.on('removeElement', (componentId) => {
            PubSub.publish(componentId, {
                type: "removeElement",
                componentId: componentId
            });
        });

        connection.on('clearElement', (componentId) => {
            PubSub.publish(componentId, {
                type: "clearElement",
                componentId: componentId
            });
        });

        connection.on('syncElement', (componentId) => {
            PubSub.publish(componentId, {
                type: "syncElement",
                componentId: componentId
            });
        });

        connection.on('addElement', (componentId, elements) => {
            PubSub.publish(componentId, {
                type: "addElement",
                componentId: componentId,
                elements: elements
            });
        });

        connection.on('showModal', (props) => {
            PubSub.publish("modal.open", props);
        });

        connection.on('closeModal', () => {
            PubSub.publish("modal.close", {});
        });

        connection.on('redirect', (url, newWindow) => {
            if (newWindow) {
                window.open(url);
            }
            else {
                window.location.href = url;
            }
        });

        PubSub.subscribe('element-event', function(e, data) {
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
            PubSub.publish(event.id, event);
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

            if(dashboard.fontIconStyle == 'FontAwesome'){
                import("font-awesome/css/font-awesome.min.css" /* webpackChunkName: "font-awesome" */);
            }else {
                import("line-awesome/css/line-awesome.min.css" /* webpackChunkName: "line-awesome" */);
            }
            
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
            return <Redirect to={`/${defaultHomePage.name.replace(/ /g,"-")}`}/>
        }
        else if (defaultHomePage.url != null && defaultHomePage.url.indexOf(":") === -1) {
            return <Redirect to={defaultHomePage.url}/>
        }
        else if (defaultHomePage.name == null) {
            return <Suspense fallback={<div></div>}>
                        <UdErrorCardComponent message="Your first page needs to be a static page or a dynamic page without a variable in the URL." />
                    </Suspense>
        }
        else {
            return <Redirect to={`/${defaultHomePage.name.replace(/ /g,"-")}`}/>
        }
    }

    render() {
        if (this.state.hasError) {
            return <Suspense fallback={<div></div>}>
                        <UdErrorCardComponent message={this.state.error.message} location={this.state.error.stackTrace} />
                    </Suspense>
        }

        if (this.state.loading) {
            return <Suspense fallback={<div></div>}>
                        <UdLoadingComponent />
                    </Suspense>
        }

        var dynamicPages = this.state.dashboard.pages.map(function(x) {
            if (!x.dynamic) return null;

            return <Route path={x.url} render={props => (
                <UdPage id={x.id} dynamic={true} {...props} autoRefresh={x.autoRefresh} refreshInterval={x.refreshInterval} key={props.location.key}/>
            )} />
        })

        var staticPages = this.state.dashboard.pages.map(function(x) {
            if (x.dynamic) return null;

            return <Route path={'/' + x.name.replace(/ /g, "-")} render={props => (
                <UdPage dynamic={false} {...x} {...props} autoRefresh={x.autoRefresh} refreshInterval={x.refreshInterval} key={props.location.key}/>
            )} />
        })

        return [
                <UdNavbar backgroundColor={this.state.dashboard.navBarColor} 
                        fontColor={this.state.dashboard.navBarFontColor} 
                        text={this.state.dashboard.title} 
                        links={this.state.dashboard.navbarLinks}
                        logo={this.state.dashboard.navBarLogo}
                        pages={this.state.dashboard.pages}
                        togglePaused={this.togglePausePageCycle.bind(this)} 
                        showPauseToggle={this.state.dashboard.cyclePages}
                        history={this.props.history}
                        authenticated={this.state.authenticated}
                        />,
                <main style={{background: this.state.dashboard.backgroundColor, color: this.state.dashboard.fontColor}}>
                    <Switch>
                        {staticPages}
                        {dynamicPages}
                        <Route exact path="/" render={this.redirectToHomePage.bind(this)} />
                    </Switch>
                </main>,
                <Suspense fallback={<div></div>}>
                    <UdModalComponent />
                </Suspense>,
                <UdFooter backgroundColor={this.state.dashboard.navBarColor} fontColor={this.state.dashboard.navBarFontColor} footer={this.state.dashboard.footer} demo={this.state.dashboard.demo} />,
                <Route path="/" render={function (x) {
                    return <Suspense fallback={<div></div>}>
                        <UdPageCyclerComponent history={x.history} pages={this.state.dashboard.pages} cyclePages={this.state.dashboard.cyclePages && !this.state.pausePageCycle} cyclePagesInterval={this.state.dashboard.cyclePagesInterval} />
                    </Suspense>
                    }.bind(this)}/>,
                this.state.design ? <UDDesigner/> : <span/>
                ]
    }
}