/** @jsx jsx */
import React from 'react';
import Switch from '@material-ui/core/Switch';
import { withComponentFeatures } from './universal-dashboard';
import {FormContext} from './form';
import {jsx} from 'theme-ui'

const UDSwitch = (props) => {

    const onChange = (event, onFieldChange) => {
        onFieldChange({id: props.id, value: event.target.checked})
        props.setState({checked: event.target.checked});

        if (props.onChange) {
            props.onChange(event.target.checked)
        }
    } 

    return (
        <FormContext.Consumer>
            {
                ({onFieldChange}) => (
                    <Switch
                        key={props.key}
                        id={props.id}
                        checked={props.checked}
                        onChange={event => onChange(event, onFieldChange)}
                        disabled={props.disabled}
                        sx={{ color: 'primary' }}
                    />
                )
            }
        </FormContext.Consumer>
    )
}

export default withComponentFeatures(UDSwitch);

