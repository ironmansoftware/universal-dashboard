import React, {useState, useEffect, useReducer} from 'react';
import Stepper from '@material-ui/core/Stepper';
import Step from '@material-ui/core/Step';
import StepLabel from '@material-ui/core/StepLabel';
import Button from '@material-ui/core/Button';
import { withComponentFeatures } from 'universal-dashboard';
import Skeleton from '@material-ui/lab/Skeleton';
import { FormContext } from './form';
import { Typography } from '@material-ui/core';
import CircularProgress from '@material-ui/core/CircularProgress';
import UDIcon from './icon';

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
    const [validating, setValidating] = useState(false);
    const [valid, setValid] = useState(true);
    const [validationError, setValidationError] = useState('');

    if (content) {
        return props.render(content);
    }

    let handleNext = () => {
        if (props.activeStep === props.children.length - 1)
        {
            props.onFinish({context: fields, currentStep: props.activeStep}).then(x => {
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

    if (props.onValidateStep) {

        const handleNextAfterValid = handleNext;

        handleNext = () => {
            setValidating(true);
            props.onValidateStep({context: fields, currentStep: props.activeStep}).then(x => {
                setValidating(validating);
                var json = JSON.parse(x);

                if (Array.isArray(json))
                {
                    json = json[0]
                }

                setValid(json.valid);
                setValidationError(json.validationError);

                if (json.valid)
                {
                    handleNextAfterValid();
                }
            });
        }
    }

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
                {props.children.map((step, index) => (
                    <Step key={step.label} >
                        <StepLabel error={!valid && index === props.activeStep}>{step.label}</StepLabel>
                    </Step>
                ))}
            </Stepper>
            <div style={{ padding: '20px' }}>
                {activeStep}
                { valid ? <React.Fragment /> : <div style={{color: 'red'}} id={props.id + "-validationError"}><UDIcon icon="Exclamation" /> {validationError}</div> }
                <div style={{ padding: '20px' }}>
                    <Button
                        disabled={props.activeStep === 0}
                        onClick={handleBack}
                        id={props.id + "btnPrev"}
                    >
                    Back
                    </Button>
                    <Button variant="contained" color="primary" onClick={handleNext} id={props.id + "btnNext"}>
                        {validating ?
                        <CircularProgress size={14} /> :
                        <Typography> {props.activeStep === props.children.length - 1 ? 'Finish' : 'Next'}</Typography>}
                    </Button>
                </div>  
            </div>
        </FormContext.Provider>
    )
}

export const UDStepper = withComponentFeatures(UDStepperImpl);
export const UDStep = withComponentFeatures(UDStepImpl);