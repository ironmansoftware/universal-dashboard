import React from 'react';
import Typography from '@mui/material/Typography';
import UDIcon from '../icon';
import { Redirect } from 'react-router-dom'

const NotRunning = () => {

    const [redirect, setRedirect] = React.useState(false);

    React.useEffect(() => {
        var token = setInterval(() => {
            UniversalDashboard.get('/api/internal/dashboard', function (json) {
                setRedirect(true);
            });
        }, 5000);

        return () => { clearInterval(token) }
    }, [true]);

    if (redirect) {
        return <Redirect to="/" />
    }

    return (
        <div style={{ textAlign: 'center', marginTop: '20%' }}>
            <Typography variant="h1" id="not-found"><UDIcon icon="Exclamation" /> Dashboard is not running</Typography>
        </div>
    )
}

export default NotRunning;