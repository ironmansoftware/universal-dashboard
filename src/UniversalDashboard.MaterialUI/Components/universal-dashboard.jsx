import React, {useState, useEffect} from 'react';

export const withComponentFeatures = (component) => {

    const getComponentData = (id) => {
        return new Promise((resolve, reject) => {
            UniversalDashboard.get(`/api/internal/component/element/${id}`, (data) => {
                if (data.error) reject(data.error.message);
                else resolve(data)
            });
        });
    };

    const sendComponentState = (requestId, state) => {
        return new Promise((resolve, reject) => {
            UniversalDashboard.post(`/api/internal/component/element/sessionState/${requestId}`, state, (data) => {
                if (data.error) reject(data.error.message);
                else resolve(data)
            });
        });
    }

    const post = (id, data) => {
        return new Promise((resolve, reject) => {
            UniversalDashboard.post(`/api/internal/component/element/${id}`, data, (returnData) => {
                resolve(returnData)
            });
        });
    }

    const subscribeToIncomingEvents = (id, callback) => {
        const incomingEvent = (id, event) => {

            let type = event.type;
            if (type === "requestState")
            {
                type = "getState"
            }

            callback(type, event);
        }

        return UniversalDashboard.subscribe(id, incomingEvent);
    }

    const unsubscribeFromIncomingEvents = (token) => {
        UniversalDashboard.unsubscribe(token)
    }

    const render = (component, history) => {
        // set props version
        if (!component.version)
        {
            component.version = "0";    
        }
        
        return UniversalDashboard.renderComponent(component, history);
    }

    const highOrderComponent = (props) => {
        const [componentState, setComponentState] = useState(props);
        useEffect(() => {
            setComponentState(props);
        }, [props.version])

        const notifyOfEvent = (eventName, value) => {
            UniversalDashboard.publish('element-event', {
                type: "clientEvent",
                eventId: props.id + eventName,
                eventName: eventName,
                eventData: value
            });
        }
    
        const incomingEvent = (type, event) => {
            if (type === "setState")
                setComponentState({
                    ...componentState,
                    ...event.state
                });
    
            if (type === "getState")
                sendComponentState(event.requestId, componentState);
    
            if (type === "addElement")
            {
                let children = componentState.children;
                if (children == null)
                {
                    children = []
                }
    
                children = componentState.children.concat(event.elements);
    
                setComponentState({children});
            }
    
            if (type === "clearElement")
            {
                setComponentState({children: []});
            }
    
            if (type === "removeElement")
            {
                // This isn't great
                setComponentState({hidden: true});
            }
    
            if (type === "syncElement") 
            {
                setComponentState({...componentState, version: Math.random().toString(36).substr(2, 5) })
            }
        }
        
        useEffect(() => {
            const token = subscribeToIncomingEvents(props.id, incomingEvent)
            return () => {
                unsubscribeFromIncomingEvents(token)
                // PubSub.publish('element-event', {
                //     type: "unregisterEvent",
                //     eventId: this.props.id
                // });
            }
        })

        const additionalProps = {
            render,
            setState: (state) => {
                let newComponentState = {
                    ...componentState,
                    ...state
                }
                setComponentState(newComponentState);
            },
            notifyOfEvent,
            post
        }

        Object.keys(componentState).forEach(x => {
            if (componentState[x] != null && componentState[x].endpoint)
            {
                additionalProps[x] = (data) => {
                    return post(componentState[x].name, data)
                }
            }
        })
        
        if (componentState.hidden) {
            return <React.Fragment />
        }

        return component({...componentState, ...additionalProps})
    }

    return highOrderComponent;
}