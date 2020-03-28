import React, {useEffect, useState} from 'react';
import { CircularProgress } from '@material-ui/core';
import { withComponentFeatures } from './universal-dashboard';
import ReactInterval from 'react-interval';

const UDDynamic = (props) => {
    const [component, setComponent] = useState({});
    const [loading, setLoading] = useState(true);

    const loadData = () => {
        props.post(props.id, {}).then(x => {

            if (Array.isArray(x)) {
                x.forEach(y => y.version = props.version);
            }

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
        if (props.loadingComponent) {
            return props.render(props.loadingComponent);
        }
        return <CircularProgress />
    }

    return [
        props.render(component),
        <ReactInterval enabled={props.autoRefresh} timeout={props.autoRefreshInterval * 1000} callback={refresh} />
    ]
}

export default withComponentFeatures(UDDynamic);