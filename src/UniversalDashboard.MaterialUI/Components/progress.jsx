import React from 'react';
import CircularProgress from '@material-ui/core/CircularProgress';
import LinearProgress from '@material-ui/core/LinearProgress';

export default function Progress(props) {

    if (props.circular) {
        return <CircularProgress />
    }

    return <LinearProgress />
}