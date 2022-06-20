import React, { useEffect } from 'react';
import Switch from '@mui/material/Switch';
import Grid from '@mui/material/Grid';
import { withComponentFeatures } from 'universal-dashboard';
import { FormContext } from './form';

const UDSwitchWithContext = (props) => {
    return (
        <FormContext.Consumer>
            {
                ({ onFieldChange }) => <UDSwitch {...props} onFieldChange={onFieldChange} />
            }
        </FormContext.Consumer>
    )
}

const UDSwitch = (props) => {

    const onChange = (event) => {
        props.onFieldChange({ id: props.id, value: event.target.checked })
        props.setState({ checked: event.target.checked });

        if (props.onChange) {
            props.onChange(event.target.checked)
        }
    }

    useEffect(() => {
        props.onFieldChange({ id: props.id, value: props.checked });
        return () => { }
    }, true)

    const switchC = <Switch
        className={props.className}
        color={props.color}
        key={props.key}
        id={props.id}
        checked={props.checked}
        onChange={event => onChange(event)}
        disabled={props.disabled}
    />

    return props.checkedLabel || props.uncheckedLabel || props.label ? (
        <Grid component="label" container alignItems="center" spacing={1}>
            <Grid item>{props.uncheckedLabel}</Grid>
            <Grid item>
                {switchC}
            </Grid>
            <Grid item>{props.checkedLabel || props.label}</Grid>
        </Grid>
    ) : switchC
}

export default withComponentFeatures(UDSwitchWithContext);

