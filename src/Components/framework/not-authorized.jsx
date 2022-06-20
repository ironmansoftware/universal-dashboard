import React from 'react';
import Typography from '@mui/material/Typography';
import UDIcon from '../icon';
import { withComponentFeatures } from 'universal-dashboard';

const NotAuthorized = (props) => {
    const [comp, setComponent] = React.useState(null);
    React.useEffect(() => {
        if (props.notAuthorized) {
            props.notAuthorized().then(json => setComponent(json));
        }
        return () => { }
    }, [])

    if (comp === null) return <></>
    var element = props.render(JSON.parse(comp));
    return element;
}

export default withComponentFeatures(NotAuthorized);