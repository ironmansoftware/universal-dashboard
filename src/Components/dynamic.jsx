import React, { useEffect, useState } from 'react';
import { withComponentFeatures } from 'universal-dashboard';
import ReactInterval from 'react-interval';

const UDDynamic = (props) => {
    const [component, setComponent] = useState({});
    const [loading, setLoading] = useState(props.loadingComponent != null);

    const loadData = () => {
        setLoading(props.loadingComponent != null);
        props.get(props.id).then(x => {

            if (Array.isArray(x)) {
                x.forEach(y => y.__version = props.__version);
            }

            setComponent(x);
            setLoading(false);
        });
    }

    const refresh = () => {
        props.setState({ __version: Math.random().toString(36).substr(2, 5) });
    }

    useEffect(() => {
        loadData();

        return () => { }
    }, [props.__version])

    if (loading) {
        return props.render(props.loadingComponent);
    }

    return [
        props.render(component),
        <ReactInterval enabled={props.autoRefresh} timeout={props.autoRefreshInterval * 1000} callback={refresh} />
    ]
}

export default withComponentFeatures(UDDynamic);