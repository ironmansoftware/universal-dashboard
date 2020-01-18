import React, { useEffect, useState, useRef } from 'react';
import Tab from 'react-materialize/lib/Tab'

const SET_STATE = "setState";
const REQUEST_STATE = "requestState";
const REMOVE_ELEMENT = "removeElement";
const ADD_ELEMENT = "addElement";
const CLEAR_ELEMENT = "clearElement";
const SYNC_ELEMENT = "syncElement";

const UDTab = props => {
    const [tabContent, setTabContent] = useState(props.content)
    const tabRef = useRef()
    useEffect(() => {
        const pubSubToken = UniversalDashboard.subscribe(props.id, events);
        return () => UniversalDashboard.unsubscribe(pubSubToken);
    }, [props.id]);

    const events = (msg, event) => {
        switch (event.type) {
            case SYNC_ELEMENT:
                UniversalDashboard.get(
                    `/api/internal/component/element/${props.id}`,
                    data =>
                        setTabContent(data)
                );
                break;
            default:
                break;
        }
    }

    const reload = () => {
        UniversalDashboard.get(
            `/api/internal/component/element/${props.id}`,
            data =>
                setTabContent(data)
        )
    }
    return <Tab
        options={{
            duration: 300,
            onShow: props.isEndpoint ? reload : null,
            responsiveThreshold: Infinity,
            swipeable: false
        }}
        title={`${props.title}`}>
        {UniversalDashboard.renderComponent(tabContent)}
    </Tab>
}

export default UDTab
