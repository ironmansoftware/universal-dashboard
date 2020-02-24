import React from 'react';
import { withComponentFeatures } from './universal-dashboard';
import {FormContext} from './form';

import 'date-fns';
import DateFnsUtils from '@date-io/date-fns';
import { KeyboardDatePicker, MuiPickersUtilsProvider } from '@material-ui/pickers';

  const DateTimePicker = (props) => {

    const onChange = (value, onFieldChange) => {
        onFieldChange({id: props.id, value });
        props.setState({ value });
        if (props.onChange) {
            props.onChange(value);
        }
    }

    return (
        <FormContext.Consumer>
            {
                ({onFieldChange}) => (
                    <MuiPickersUtilsProvider utils={DateFnsUtils}>
                        <KeyboardDatePicker
                            {...props}
                            onChange={value => onChange(value, onFieldChange)}
                        />
                    </MuiPickersUtilsProvider>
                )
            }
        </FormContext.Consumer>
    )
  } 

  export default withComponentFeatures(DateTimePicker);