/** @jsx jsx */

import React from 'react';
import { withComponentFeatures } from './universal-dashboard';
import {FormContext} from './form';
import {jsx} from 'theme-ui'
import RadioGroup from '@material-ui/core/RadioGroup';
import Radio from '@material-ui/core/Radio';
import FormControlLabel from '@material-ui/core/FormControlLabel';

export const UDRadioGroup = withComponentFeatures((props) => {

    const onChange = (event, onFieldChange) => {
        onFieldChange({id: props.id, value : event.target.value})
        props.setState({ value : event.target.value})

        if (props.onChange) {
            props.onChange(event.target.value);
        }
    }

    return (
        <FormContext.Consumer>
        {
            ({onFieldChange}) => (
                <RadioGroup label={props.label} value={props.value} onChange={e => onChange(e, onFieldChange)}>
                    {props.render(props.children)}
                </RadioGroup>
            )
        }
        </FormContext.Consumer>
    )
})

export const UDRadio = withComponentFeatures((props) => {
    return (
        <FormControlLabel {...props} control={<Radio/>}></FormControlLabel>
        
    )
})