import React, {useState, useEffect, useReducer} from 'react';
import Stepper from '@material-ui/core/Stepper';
import Step from '@material-ui/core/Step';
import StepLabel from '@material-ui/core/StepLabel';
import Button from '@material-ui/core/Button';
import { withComponentFeatures } from './universal-dashboard';
import Skeleton from '@material-ui/lab/Skeleton';
import { FormContext } from './form';

const reducer = (state, action) => {
    switch (action.type) {
        case 'changeField':
            var newState = {...state};
            newState[action.id] = action.value;
            return newState;
        default:
          throw new Error();
      }
}

const UDStepImpl = (props) => {

    const [content, setContent] = useState(null);

    useEffect(() => {
        props.onLoad({context: props.context}).then(x => {

            try {
                x = JSON.parse(x);
            } catch {}

            setContent(x);
        })
    }, [true]);

    if (content == null) {
        return <Skeleton />
    }

    return (
        props.render(content)
    )
}


const UDStepperImpl = (props) => {

    const [fields, setFields] = useReducer(reducer, {});
    const [content, setContent] = useState(null);

    if (content) {
        return props.render(content);
    }

    const handleNext = () => {

        if (props.activeStep === props.children.length - 1)
        {
            props.onFinish({context: fields}).then(x => {
                var json = JSON.parse(x);
                setContent(json);
            });
        }
        else 
        {
            props.setState({ activeStep : props.activeStep + 1})
        }
    };

    const handleBack = () => {
        props.setState({ activeStep : props.activeStep - 1})
    };

    const activeStep = props.render({...props.children[props.activeStep], context: fields });

    const contextState = {
        onFieldChange: (field) => {
            setFields({
                type: 'changeField',
                ...field
            });
        }
    }

    return (
        <FormContext.Provider value={contextState}>
            <Stepper activeStep={props.activeStep} id={props.id}>
                {props.children.map(step => (
                    <Step key={step.label}>
                        <StepLabel>{step.label}</StepLabel>
                    </Step>
                ))}
            </Stepper>
            <div>
                {activeStep}
                <div>
                    <Button
                        disabled={props.activeStep === 0}
                        onClick={handleBack}
                        id={props.id + "btnPrev"}
                    >
                    Back
                </Button>
                <Button variant="contained" color="primary" onClick={handleNext} id={props.id + "btnNext"}>
                    {props.activeStep === props.children.length - 1 ? 'Finish' : 'Next'}
                </Button>
                </div>  
            </div>
        </FormContext.Provider>
    )
}

export const UDStepper = withComponentFeatures(UDStepperImpl);
export const UDStep = withComponentFeatures(UDStepImpl);