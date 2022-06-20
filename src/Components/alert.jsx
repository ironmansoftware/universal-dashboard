import React from 'react';
import { Alert, AlertTitle } from '@mui/material';
import { withComponentFeatures } from 'universal-dashboard';

function UDAlert(props) {
    return <Alert severity={props.severity} key={props.id} id={props.id} className={props.className}>
        {props.title && props.title !== "" ? <AlertTitle>{props.title}</AlertTitle> : <React.Fragment />}
        {props.render(props.children)}
    </Alert>
}

export default withComponentFeatures(UDAlert);