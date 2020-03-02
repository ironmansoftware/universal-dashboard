import React from 'react';
import Typography from '@material-ui/core/Typography';
import UDIcon from '../icon';

export default class NotFound extends React.Component {
    render() {
        return (
            <div style={{textAlign: 'center', marginTop: '20%'}}>
                <Typography variant="h1" id="not-found"><UDIcon icon="QuestionCircle"/> Page Not Found</Typography>
            </div>
        )
    }
}