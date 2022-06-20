import React, { useEffect } from 'react';
import { withComponentFeatures } from 'universal-dashboard';
import { FormContext } from './form';
import RadioGroup from '@mui/material/RadioGroup';
import Radio from '@mui/material/Radio';
import FormControlLabel from '@mui/material/FormControlLabel';

export const UDRadioGroupWithContext = withComponentFeatures((props) => {
    return (
        <FormContext.Consumer>
            {
                ({ onFieldChange }) => <UDRadioGroup {...props} onFieldChange={onFieldChange} />
            }
        </FormContext.Consumer>
    )
})

const UDRadioGroup = (props) => {

    const onChange = (event) => {
        props.onFieldChange({ id: props.id, value: event.target.value })
        props.setState({ value: event.target.value })

        if (props.onChange) {
            props.onChange(event.target.value);
        }
    }

    useEffect(() => {
        props.onFieldChange({ id: props.id, value: props.value });
        return () => { }
    }, true)

    return (
        <RadioGroup id={props.id} label={props.label} value={props.value} onChange={e => onChange(e)}>
            {props.render(props.children)}
        </RadioGroup>
    )
}

export const UDRadio = withComponentFeatures((props) => {
    return (
        <FormControlLabel {...props} control={<Radio />}></FormControlLabel>

    )
})