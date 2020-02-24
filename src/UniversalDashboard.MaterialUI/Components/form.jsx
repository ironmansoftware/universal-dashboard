import React, {useState} from 'react';
import { Button } from '@material-ui/core';
import { withComponentFeatures } from './universal-dashboard';

const defaultContext = {
    fields: {},
    onFieldChange: (field) => {}
}

export const FormContext = React.createContext(defaultContext);

const UDForm = (props) => {
    const [fields, setFields] = useState({});
    const [valid, setValid] = useState(props.onValidate == null);

    const components = props.render(props.content);

    const onSubmit = () => {
        props.onSubmit(fields).then(x => {

        })
    }

    const onValidate = () => {
        if (props.onValidate) {
            props.onValidate(fields).then(x => {
                if (x) {
                    setValid(x)
                }
            });
        } else {
            setValid(true);
        }
    }
    
    const contextState = {
        fields, 
        onFieldChange: (field) => {

            var state = {...fields};
            state[field.id] = field.value;

            setFields(state);
        }
    }

    return (
        <div id={props.id}>
            <FormContext.Provider value={contextState}>
                {components}
                <Button onClick={onSubmit} disabled={!valid}>Submit</Button>
            </FormContext.Provider>
        </div>
    )
}

export default withComponentFeatures(UDForm);
