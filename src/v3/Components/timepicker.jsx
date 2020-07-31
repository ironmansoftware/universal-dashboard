import React, {useEffect} from 'react';
import { withComponentFeatures } from 'universal-dashboard';
import {FormContext} from './form';

import 'date-fns';
import DateFnsUtils from '@date-io/date-fns';
import { KeyboardTimePicker, MuiPickersUtilsProvider } from '@material-ui/pickers';

const TimePickerWithContext = props => {
    return (
        <FormContext.Consumer>
            {
                ({onFieldChange}) => <TimePicker {...props} onFieldChange={onFieldChange} />
            }
        </FormContext.Consumer>
    )
}

  const TimePicker = (props) => {

    const onChange = (value) => {
        props.onFieldChange({id: props.id, value });
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

    useEffect(() => {
        props.onFieldChange({id: props.id, value: props.value});
        return () => {}
    }, true)

    return (
        <MuiPickersUtilsProvider utils={DateFnsUtils} >
            <KeyboardTimePicker
                {...props}
                value={value}
                onChange={value => onChange(value)}
            />
        </MuiPickersUtilsProvider>
    )
  } 

  export default withComponentFeatures(TimePickerWithContext);