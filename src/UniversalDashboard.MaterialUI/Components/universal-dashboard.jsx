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

    const notifyOfEvent = (id, eventName, value) => {
        UniversalDashboard.publish('element-event', {
            type: "clientEvent",
            eventId: id,
            eventName: eventName,
            eventData: value
        });
    }


    const highLevelComponent = (props) => {
        const [componentState, setComponentState] = useState(props);

        const incomingEvent = (type, event) => {
            if (type == "setState")
                setComponentState({
                    ...componentState,
                    ...event.state
                });
    
            if (type == "getState")
                sendComponentState(event.requestId, componentState);
    
            if (type == "addElement")
            {
                let children = componentState.children;
                if (children == null)
                {
                    children = []
                }
    
                children = componentState.children.concat(event.elements);
    
                setComponentState({children});
            }
    
            if (type == "clearElement")
            {
                setComponentState({children: []});
            }
    
            if (type == "removeElement")
            {
                // This isn't great
                setComponentState({hidden: true});
            }
    
            if (type = "syncElement") 
            {
                getComponentData(componentState.id).then(x => setComponentState({
                    ...componentState, 
                    ...x
                })).catch(x => {
                    //TODO
                });
            }
        }
        
        useEffect(() => {
            const token = subscribeToIncomingEvents(props.id, incomingEvent)
            return () => unsubscribeFromIncomingEvents(token)
        })

        const additionalProps = {
            render: UniversalDashboard.renderComponent,
            setState: (state) => {
                let newComponentState = {
                    ...componentState,
                    ...state
                }
                setComponentState(newComponentState);
            },
            notifyOfEvent
        }
        
        if (componentState.hidden) {
            return <React.Fragment />
        }

        return component({...componentState, ...additionalProps})
    }

    return highLevelComponent;
}