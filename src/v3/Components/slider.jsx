import React, { useEffect } from 'react';
import {withComponentFeatures} from 'universal-dashboard';
import Slider from '@material-ui/core/Slider';
import {FormContext} from './form';

const UDSliderWithContext = (props) => {
    return (
        <FormContext.Consumer>
            {
                ({onFieldChange}) => <UDSlider {...props} onFieldChange={onFieldChange} />
            }
        </FormContext.Consumer>
    )
}

const UDSlider = (props) => {
    const onChange = (e, value) => {
        props.setState({ value })
        props.onFieldChange({id: props.id, value });
    }

    const onChangeCommitted = (e, value) => {
        if (props.onChange)
        {
            props.onChange(value);
        }
    }

    useEffect(() => {
        props.onFieldChange({id: props.id, value: props.value });
        return () => {}
    }, true)

    return <Slider {...props} onChangeCommitted={onChangeCommitted} onChange={onChange} key={props.id} />
}

export default withComponentFeatures(UDSliderWithContext);