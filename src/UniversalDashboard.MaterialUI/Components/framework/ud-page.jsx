import React, { useState, useEffect } from 'react';
import ErrorCard from './error-card.jsx';
import ReactInterval from 'react-interval';
import UDNavbar from './ud-navbar';
import UDFooter from './ud-footer';
import {withComponentFeatures} from '../universal-dashboard';
import Container from '@material-ui/core/Container';

const UDPage = (props) => {

    document.title = props.name;

    const [components, setComponents] = useState([]);
    const [hasError, setHasError] = useState(false);
    const [errorMessage, setErrorMessage] = useState('');

    const loadData = () => {
        if (props.dynamic) 
        {
            loadDynamicPage();
        } else {
            loadStaticPage();
        }        
    }

    const loadStaticPage = () => {
        UniversalDashboard.get(`/api/internal/dashboard/page/${props.name}`, json => {
            if (json.error) {
                setErrorMessage(json.error.message);
                setHasError(true);
            }
            else  {
                setComponents(json.components);
                setHasError(false);
            }
        });
    }
    
    const loadDynamicPage = () => {
        if (!props.match) {
            return;
        }

        var queryParams = {};

        for (var k in props.match.params) {
            if (props.match.params.hasOwnProperty(k)) {
                queryParams[k] = props.match.params[k];
            }
        }

        var esc = encodeURIComponent;
        var query = Object.keys(queryParams)
            .map(k => esc(k) + '=' + esc(queryParams[k]))
            .join('&');
    
        UniversalDashboard.get(`/api/internal/component/element/${props.id}?${query}`, json => {
            if (json.error) {
                setErrorMessage(json.error.message);
                setHasError(true);
            }
            else  {
                setComponents(json.components);
                setHasError(false);
            }
        });
    }

    useEffect(() => {
        loadData();
        return () => {}
    }, true)

    
    if (hasError) {
        return <ErrorCard message={errorMessage} id={props.id} title={"An error occurred on this page"}/>
    }

    if (!components || !components.map) {
        var parameterName = props.dynamic ? "Endpoint" : "Content";
        return <ErrorCard message={`There was an error with your ${parameterName} for this page. You need to return at least one component from the ${parameterName}.`} />
    } 

    var childComponents = components.map(x => {
        return props.render(x, props.history);
    });

    if (props.blank)
    {
        return [
            childComponents,
            <ReactInterval timeout={props.refreshInterval * 1000} enabled={props.autoRefresh} callback={loadData}/>
        ]
    }
    else 
    {
        return [
            <UDNavbar pages={props.pages} title={props.name} history={props.history} />,
            <Container>
                {childComponents}
            </Container>,
            <ReactInterval timeout={props.refreshInterval * 1000} enabled={props.autoRefresh} callback={loadData}/>,
           // <UDFooter />
        ]
    }
}

export default withComponentFeatures(UDPage);