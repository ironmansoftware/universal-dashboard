import React from 'react';
import Typography from '@mui/material/Typography';
import UDIcon from '../icon';
import { withComponentFeatures } from 'universal-dashboard';

const NotFound = (props) => {
    const [comp, setComponent] = React.useState(null);
    React.useEffect(() => {
        if (props.pageNotFound) {
            props.pageNotFound().then(json => setComponent(json));
        }
        return () => { }
    }, [])

    if (props.pageNotFound) {
        if (comp === null) return <></>
        var element = props.render(JSON.parse(comp));
        return element;
    } else {
        return <div style={{ textAlign: 'center', marginTop: '20%' }}>
            <Typography variant="h1" id="not-found"><UDIcon icon="QuestionCircle" /> Page Not Found</Typography>
        </div>
    }
}

export default withComponentFeatures(NotFound);