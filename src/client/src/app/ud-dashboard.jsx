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
import NotFound from './not-found.jsx';

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
            design: false,
            title: ''
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

        connection.on('showError', (model) => {
            toaster.error(model);
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

            if (componentId == null) return;

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

        connection.on('select', (ID, scrollToElement) => {
            document.getElementById(ID).focus();
            if (scrollToElement) {
                document.getElementById(ID).scrollIntoView();
            }
        });

        connection.on('clipboard', (Data, toastOnSuccess, toastOnError) => {
            var textArea = document.createElement("textarea");
            textArea.style.position = 'fixed';
            textArea.style.top = 0;
            textArea.style.left = 0;
            textArea.style.width = '2em';
            textArea.style.height = '2em';
            textArea.style.padding = 0;
            textArea.style.border = 'none';
            textArea.style.outline = 'none';
            textArea.style.boxShadow = 'none';
            textArea.style.background = 'transparent';
            textArea.value = Data;
            document.body.appendChild(textArea);
            textArea.focus();
            textArea.select();

            try {
                var successful = document.execCommand('copy');
                if(toastOnSuccess) {
                    toaster.show({
                        message: 'Copied to clipboard',
                    });
                }
            } catch (err) {
                if (toastOnError) {
                    toaster.show({
                        message: 'Unable to copy to clipboard',
                    });
                }
            }
        
            document.body.removeChild(textArea);
        });

        connection.on('write', (message) => {
            PubSub.publish("write", message);
        });

        connection.on('setConnectionId', (id) => {
            UniversalDashboard.connectionId = id;
            this.setState({
                loading: false
            })
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

    loadJavascript(url, onLoad) {
        var jsElm = document.createElement("script");
        jsElm.onload = onLoad;
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

            UniversalDashboard.design = dashboard.design;

            this.setState({
                dashboard: dashboard,
                sessionId:  json.sessionId,
                authenticated: json.authenticated,
                design: dashboard.design,
                title: dashboard.title
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
            return <Suspense fallback={<div></div>}>
                        <UdErrorCardComponent message="Your first page needs to be a static page or a dynamic page without a variable in the URL." />
                    </Suspense>
        }
        else {
            return <Redirect to={window.baseUrl + `/${defaultHomePage.name.replace(/ /g,"-")}`}/>
        }
    }
    
    onTitleChanged(title) {
        this.setState({
            title
        })
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

        var _this = this;
        var dynamicPages = this.state.dashboard.pages.map(function(x) {
            if (!x.dynamic) return null;

            if (!x.url.startsWith("/")) {
                x.url = "/" + x.url;
            }

            return <Route key={x.url} path={window.baseUrl + x.url} render={props => (
                <UdPage onTitleChanged={_this.onTitleChanged.bind(_this)} id={x.id} dynamic={true} {...props} autoRefresh={x.autoRefresh} refreshInterval={x.refreshInterval} key={props.location.key}/>
            )} />
        })

        var staticPages = this.state.dashboard.pages.map(function(x) {
            if (x.dynamic) return null;

            return <Route key={x.name} exact path={window.baseUrl + '/' + x.name.replace(/ /g, "-")} render={props => (
                <UdPage onTitleChanged={_this.onTitleChanged.bind(_this)} dynamic={false} {...x} {...props} autoRefresh={x.autoRefresh} refreshInterval={x.refreshInterval} key={props.location.key}/>
            )} />
        })

        var pluginComponents = UniversalDashboard.provideDashboardComponents(this.state);

        return [
                <header>
                    <UdNavbar backgroundColor={this.state.dashboard.navBarColor} 
                            fontColor={this.state.dashboard.navBarFontColor} 
                            text={this.state.title} 
                            links={this.state.dashboard.navbarLinks}
                            logo={this.state.dashboard.navBarLogo}
                            pages={this.state.dashboard.pages}
                            togglePaused={this.togglePausePageCycle.bind(this)} 
                            showPauseToggle={this.state.dashboard.cyclePages}
                            history={this.props.history}
                            authenticated={this.state.authenticated}
                            navigation={this.state.dashboard.navigation}
                            />
                </header>,
                <main style={{background: this.state.dashboard.backgroundColor, color: this.state.dashboard.fontColor}}>
                    <Suspense fallback={<span/>}>
                        <Switch>
                            {staticPages}
                            {dynamicPages}
                            <Route exact path={window.baseUrl + `/`} render={this.redirectToHomePage.bind(this)} />
                            <Route path={window.baseUrl + `/`} render={() => <NotFound/>} />
                        </Switch>
                    </Suspense>
                </main>,
                <Suspense fallback={<div></div>}>
                    <UdModalComponent />
                </Suspense>,
                <UdFooter backgroundColor={this.state.dashboard.navBarColor} fontColor={this.state.dashboard.navBarFontColor} footer={this.state.dashboard.footer} demo={this.state.dashboard.demo} />,
                <Route path={window.baseUrl + `/`} render={function (x) {
                    return <Suspense fallback={<div></div>}>
                        <UdPageCyclerComponent history={x.history} pages={this.state.dashboard.pages} cyclePages={this.state.dashboard.cyclePages && !this.state.pausePageCycle} cyclePagesInterval={this.state.dashboard.cyclePagesInterval} />
                    </Suspense>
                    }.bind(this)}
                />,
                pluginComponents
                ]
    }
}
