/** @jsx jsx */
import React from 'react';
import {withComponentFeatures} from './universal-dashboard';
import TextField from '@material-ui/core/TextField';
import {FormContext} from './form';
import {jsx} from 'theme-ui'

const UDTextField = (props) => {
    return (
        <FormContext.Consumer>
            {
                ({onFieldChange}) => {
                    const onChange = (e) => {
                        props.setState({value: e.target.value})
                        onFieldChange({id: props.id, value: e.target.value})
                    }

                    return <TextField  {...props} sx={{bg: 'primary'}} type={props.textType} onChange={onChange}/>
                }
            }
        </FormContext.Consumer>
    )
}

export default withComponentFeatures(UDTextField);