import React from 'react';
import { withComponentFeatures } from './universal-dashboard';
import {FormContext} from './form';

import 'date-fns';
import DateFnsUtils from '@date-io/date-fns';
import { KeyboardTimePicker, MuiPickersUtilsProvider } from '@material-ui/pickers';

  const TimePicker = (props) => {

    const onChange = (value, onFieldChange) => {
        onFieldChange({id: props.id, value });
        props.setState({ value });
        if (props.onChange) {
            props.onChange(value);
        }
    }

    var value = props.value;
    if (value === "")
    {
        value = null;
    }

    return (
        <FormContext.Consumer>
            {
                ({onFieldChange}) => (
                    <MuiPickersUtilsProvider utils={DateFnsUtils} >
                        <KeyboardTimePicker
                            {...props}
                            value={value}
                            onChange={value => onChange(value, onFieldChange)}
                        />
                    </MuiPickersUtilsProvider>
                )
            }
        </FormContext.Consumer>
    )
  } 

  export default withComponentFeatures(TimePicker);