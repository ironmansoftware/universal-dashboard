import React, {useEffect} from 'react';
import { withComponentFeatures } from 'universal-dashboard';
import {FormContext} from './form';

import 'date-fns';
import DateFnsUtils from '@date-io/date-fns';
import { KeyboardDatePicker, MuiPickersUtilsProvider } from '@material-ui/pickers';

const DatePickerWithContext = (props) => {
    return (
        <FormContext.Consumer>
            {
                ({onFieldChange}) => <DateTimePicker {...props} onFieldChange={onFieldChange} /> 
            }
        </FormContext.Consumer>
    )
}

  const DateTimePicker = (props) => {

    const onChange = (value) => {
        props.onFieldChange({id: props.id, value });
        props.setState({ value });
        if (props.onChange) {
            props.onChange(value);
        }
    }

    useEffect(() => {
        props.onFieldChange({id: props.id, value: props.value});
        return () => {}
    }, true)

    return (
        <MuiPickersUtilsProvider utils={DateFnsUtils}>
            <KeyboardDatePicker
                {...props}
                onChange={value => onChange(value)}
            />
        </MuiPickersUtilsProvider>
    )
  } 

  export default withComponentFeatures(DatePickerWithContext);