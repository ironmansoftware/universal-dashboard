import React, {useEffect, useState} from 'react';
import { CircularProgress } from '@material-ui/core';
import { withComponentFeatures } from './universal-dashboard';
import ReactInterval from 'react-interval';

const UDDynamic = (props) => {
    const [component, setComponent] = useState({});
    const [loading, setLoading] = useState(true);

    const loadData = () => {
        props.post(props.id, {}).then(x => {
            setComponent(x);
            setLoading(false);
        });
    }

    const refresh = () => {
        props.setState({version: Math.random().toString(36).substr(2, 5)});
    }

    useEffect(() => {
        loadData();

        return () => {}
    }, [props.version])

    if (loading) {
        return <CircularProgress />
    }

    return [
        props.render(component),
        <ReactInterval enabled={props.autoRefresh} timeout={props.autoRefreshInterval * 1000} callback={refresh} />
    ]
}

export default withComponentFeatures(UDDynamic);