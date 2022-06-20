import React, { useEffect } from 'react';
import { withComponentFeatures } from 'universal-dashboard';
import { FormContext } from './form';
import 'date-fns';

import AdapterDateFns from '@mui/lab/AdapterDateFns';
import LocalizationProvider from '@mui/lab/LocalizationProvider';
import DatePicker from '@mui/lab/DatePicker';
import TextField from "@mui/material/TextField";


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

const DatePickerWithContext = (props) => {
    return (
        <FormContext.Consumer>
            {
                ({ onFieldChange }) => <DateTimePicker {...props} onFieldChange={onFieldChange} />
            }
        </FormContext.Consumer>
    )
}

const DateTimePicker = (props) => {

    const onChange = (value) => {
        props.onFieldChange({ id: props.id, value });
        props.setState({ value });
        if (props.onChange) {
            props.onChange(value);
        }
    }

    useEffect(() => {
        props.onFieldChange({ id: props.id, value: props.value });
        return () => { }
    }, true)

    return (
        <LocalizationProvider dateAdapter={AdapterDateFns} locale={locales[props.locale]}>
            <DatePicker
                {...props}
                value={props.value}
                onChange={value => onChange(value)}
                renderInput={(params) => <TextField {...params} />}
            />
        </LocalizationProvider>
    )
}

export default withComponentFeatures(DatePickerWithContext);