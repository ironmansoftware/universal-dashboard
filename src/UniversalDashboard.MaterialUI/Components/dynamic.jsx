import React, {useEffect, useState} from 'react';
import { CircularProgress } from '@material-ui/core';
import { withComponentFeatures } from './universal-dashboard';
import ReactInterval from 'react-interval';

const UDDynamic = (props) => {
    const [component, setComponent] = useState({ loading: true });

    const loadData = () => {
        props.post(props.id, {}).then(x => {
            setComponent({...x[0], 
                loading: false, 
                version: Math.random().toString(36).substr(2, 5)
            });
        });
    }

    useEffect(() => {
        loadData();

        return () => {}
    }, [props.version])

    if (component.loading) {
        return <CircularProgress />
    }

    return [
        props.render(component),
        <ReactInterval enabled={props.autoRefresh} timeout={props.autoRefreshInterval * 1000} callback={loadData} />
    ]
}

export default withComponentFeatures(UDDynamic);