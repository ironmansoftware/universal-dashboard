/** @jsx jsx */
import React, { useEffect } from 'react';
import {withComponentFeatures} from './universal-dashboard';
import TextField from '@material-ui/core/TextField';
import {FormContext} from './form';
import {jsx} from 'theme-ui'

const UDTextFieldWithContext = (props) => {
    return (
        <FormContext.Consumer>
            {
                ({onFieldChange}) => <UDTextField {...props} onFieldChange={onFieldChange} />
            }
        </FormContext.Consumer>
    )
}

const UDTextField = (props) => {
    const onChange = (e) => {
        props.setState({value: e.target.value})
        props.onFieldChange({id: props.id, value: e.target.value})
    }

    useEffect(() => {
        props.onFieldChange({id: props.id, value: props.value});
        return () => {}
    }, true)

    return <TextField  {...props} type={props.textType} onChange={onChange} />
}

export default withComponentFeatures(UDTextFieldWithContext);