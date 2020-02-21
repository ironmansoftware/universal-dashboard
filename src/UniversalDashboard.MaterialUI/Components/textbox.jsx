import React from 'react';
import {withComponentFeatures} from './universal-dashboard';
import TextField from '@material-ui/core/TextField';

const UDTextField = (props) => {
    return (
        <TextField {...props} type={props.textType} onChange={e => props.setState({value: e.target.value})}/>
    )
}

export default withComponentFeatures(UDTextField);