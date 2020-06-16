import React from 'react';
import CircularProgress from '@material-ui/core/CircularProgress';
import LinearProgress from '@material-ui/core/LinearProgress';

export default function Progress(props) {

    if (props.circular) {
        return <CircularProgress id={props.id} sx={{ color: 'primary'}}/>
    }

    return <LinearProgress variant={props.variant} value={props.percentComplete} id={props.id}/>
}