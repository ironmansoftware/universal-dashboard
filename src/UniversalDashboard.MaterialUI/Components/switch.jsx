import React from 'react';
import Switch from '@material-ui/core/Switch';
import { withComponentFeatures } from './universal-dashboard';

const UDSwitch = (props) => {

    const onChange = (event) => {
        props.setState({checked: event.target.checked});

        if (props.onChange) {
            props.notifyOfEvent('onChange', event.target.checked)
        }
    } 

    return (
        <Switch
            key={props.key}
            id={props.id}
            checked={props.checked}
            onChange={onChange}
            disabled={props.disabled}
        />
    )
}

export default withComponentFeatures(UDSwitch);

