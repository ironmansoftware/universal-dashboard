import React, { useEffect } from 'react';
import { withComponentFeatures } from 'universal-dashboard';
import { FormContext } from './form';
import TextField from "@mui/material/TextField";
import TimePicker from '@mui/lab/TimePicker';
import AdapterDateFns from '@mui/lab/AdapterDateFns';
import LocalizationProvider from '@mui/lab/LocalizationProvider';

import 'date-fns';
import frLocale from "date-fns/locale/fr";
import deLocale from "date-fns/locale/de";
import enLocale from "date-fns/locale/en-US";
import ruLocale from "date-fns/locale/ru";

const locales = {
    "fr": frLocale,
    "de": deLocale,
    "en": enLocale,
    "ru": ruLocale
}

const TimePickerWithContext = props => {
    return (
        <FormContext.Consumer>
            {
                ({ onFieldChange }) => <UdTimePicker {...props} onFieldChange={onFieldChange} />
            }
        </FormContext.Consumer>
    )
}

const UdTimePicker = (props) => {

    const onChange = (value) => {
        props.onFieldChange({ id: props.id, value });
        props.setState({ value });
        if (props.onChange) {
            props.onChange(value);
        }
    }

    var value = props.value;
    if (value === "") {
        value = null;
    }

    useEffect(() => {
        props.onFieldChange({ id: props.id, value: props.value });
        return () => { }
    }, true)

    return (
        <LocalizationProvider dateAdapter={AdapterDateFns} locale={locales[props.locale]}>
            <TimePicker
                {...props}
                value={value}
                onChange={value => onChange(value)}
                renderInput={(params) => <TextField {...params} />}
            />
        </LocalizationProvider>
    )
}

export default withComponentFeatures(TimePickerWithContext);