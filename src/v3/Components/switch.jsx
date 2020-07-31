import React, {useEffect} from 'react';
import Switch from '@material-ui/core/Switch';
import { withComponentFeatures } from 'universal-dashboard';
import {FormContext} from './form';

const UDSwitchWithContext = (props) => {
    return (
        <FormContext.Consumer>
            {
                ({onFieldChange}) => <UDSwitch {...props} onFieldChange={onFieldChange} />
            }
        </FormContext.Consumer>
    )
}

const UDSwitch = (props) => {

    const onChange = (event) => {
        props.onFieldChange({id: props.id, value: event.target.checked})
        props.setState({checked: event.target.checked});

        if (props.onChange) {
            props.onChange(event.target.checked)
        }
    } 

    useEffect(() => {
        props.onFieldChange({id: props.id, value: props.checked});
        return () => {}
    }, true)

    return (
        <Switch
            key={props.key}
            id={props.id}
            checked={props.checked}
            onChange={event => onChange(event)}
            disabled={props.disabled}
        />
    )
}

export default withComponentFeatures(UDSwitchWithContext);

