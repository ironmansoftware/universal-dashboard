import React,{Suspense, useState, useEffect} from 'react';

import {getApiPath} from 'config';
import {fetchGet} from './services/fetch-service.jsx';
import PubSub from 'pubsub-js';
import { HubConnectionBuilder, LogLevel } from '@aspnet/signalr';

import toaster from './services/toaster';
import LazyElement from './basics/lazy-element.jsx';

var connection;

function connectWebSocket(sessionId, location, setLoading) {

    connection = new HubConnectionBuilder()
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

    connection.on('removeElement', (componentId, parentId) => {
        PubSub.publish(componentId, {
            type: "removeElement",
            componentId: componentId,
            parentId: parentId
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

    connection.on('select', (ParameterSetName, ID, scrollToElement) => {
        if (ParameterSetName == "ToTop") {
            window.scrollTo({ top: 0, behavior: 'smooth'});
        }
        if (ParameterSetName == "Normal") {
            document.getElementById(ID).focus();
            if (scrollToElement) {
                document.getElementById(ID).scrollIntoView();
            }
        }
    });

    connection.on('invokejavascript', (jsscript) => {
        eval(jsscript);
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
        setLoading(false);
    });

    PubSub.subscribe('element-event', function(e, data) {
        if (data.type === "requestStateResponse") {
            connection.invoke("requestStateResponse", data.requestId, data.state)
        }

        if (data.type === "clientEvent") {
            connection.invoke("clientEvent", data.eventId, data.eventName, data.eventData, location).catch(function(e) {
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
    });

    connection.start().then(x => {
        window.UniversalDashboard.webSocket = connection;
        connection.invoke("setSessionId", sessionId);
    });
}


function loadStylesheet(url) {
    var styles = document.createElement('link');
    styles.rel = 'stylesheet';
    styles.type = 'text/css';
    styles.media = 'screen';
    styles.href = url;
    document.getElementsByTagName('head')[0].appendChild(styles);
}

function loadJavascript(url, onLoad) {
    var jsElm = document.createElement("script");
    jsElm.onload = onLoad;
    jsElm.type = "application/javascript";
    jsElm.src = url;
    document.body.appendChild(jsElm);
}

function loadData(setDashboard, setLocation, history, location, setLoading) {
    fetchGet("/api/internal/dashboard", function(json) {

        var dashboard = json.dashboard;

        if (dashboard.stylesheets)
        dashboard.stylesheets.map(loadStylesheet);

        if (dashboard.scripts)
            dashboard.scripts.map(loadJavascript);

        if (dashboard.geolocation) {
            getLocation(setLocation);            
        }

        connectWebSocket(json.sessionId, location, setLoading);

        UniversalDashboard.design = dashboard.design;

        setDashboard(dashboard);
    }, history);
}


function getLocation(setLocation) {
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

            setLocation(value);
        });
    } 
}

function Dashboard({history}) {
    const [dashboard, setDashboard] = useState(null);
    const [hasError, setHasError] = useState(false);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);
    const [location, setLocation] = useState(null);

    useEffect(() => {
        if (dashboard) return;

        try 
        {
            loadData(setDashboard, setLocation, history, location, setLoading) 
        }
        catch (err)
        {
            setError(err);
            setHasError(true);
        }
    });

    if (hasError) 
    {
        return <Suspense fallback={<div></div>}>
                    <LazyElement component={{
                        type: 'error',
                        message: error.message,
                        location: error.stackTrace
                    }} />
                </Suspense>
    }

    if (loading) {
        return <Suspense fallback={<div></div>}>
                    <LazyElement component={{
                        type: 'loading'
                    }} />
                </Suspense>
    }

    try
    {
        var component = UniversalDashboard.renderDashboard({
            dashboard: dashboard, 
            history: history
        });
    
        var pluginComponents = UniversalDashboard.provideDashboardComponents();
    
        return  [component, pluginComponents]
    }
    catch (err)
    {
        setError(err);
        setHasError(true);
    }

    return null;
}

export default Dashboard;