import React, { useState, useEffect, useReducer } from 'react';
import Stepper from '@mui/material/Stepper';
import Step from '@mui/material/Step';
import StepLabel from '@mui/material/StepLabel';
import StepContent from '@mui/material/StepContent';
import Button from '@mui/material/Button';
import { withComponentFeatures } from 'universal-dashboard';
import Skeleton from '@mui/material/Skeleton';
import { FormContext } from './form';
import { Typography } from '@mui/material';
import CircularProgress from '@mui/material/CircularProgress';
import UDIcon from './icon';

const reducer = (state, action) => {
    switch (action.type) {
        case 'changeField':
            var newState = { ...state };
            newState[action.id] = action.value;
            return newState;
        default:
            throw new Error();
    }
}

const UDStepImpl = (props) => {

    const [content, setContent] = useState(null);

    useEffect(() => {
        props.onLoad({ context: props.context }).then(x => {

            try {
                x = JSON.parse(x);
            } catch { }

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
    const [disablePrevious, setDisablePrevious] = useState(false);
    const [previousStepIndex, setPreviousStepIndex] = useState(0);

    if (content) {
        return props.render(content);
    }

    let handleNext = () => {
        if (props.activeStep === props.children.length - 1) {
            props.onFinish({ context: fields, currentStep: props.activeStep }).then(x => {
                var json = JSON.parse(x);
                setContent(json);
            });
        }
        else {
            setPreviousStepIndex(props.activeStep);
            props.setState({ activeStep: props.activeStep + 1 })
        }
    };

    const handleBack = () => {
        setPreviousStepIndex(previousStepIndex - 1);
        props.setState({ activeStep: previousStepIndex })
    };

    if (props.onValidateStep) {

        const handleNextAfterValid = handleNext;

        handleNext = () => {
            setValidating(true);
            props.onValidateStep({ context: fields, currentStep: props.activeStep }).then(x => {
                setValidating(validating);
                var json = JSON.parse(x);

                if (Array.isArray(json)) {
                    json = json[0]
                }

                setValid(json.valid);
                setValidationError(json.validationError);
                setDisablePrevious(json.disablePrevious);

                if (json.context) {
                    Object.keys(json.context).forEach(x => {
                        setFields({
                            type: 'changeField',
                            id: x,
                            value: json.context[x]
                        });
                    })
                }

                if (json.valid) {
                    handleNextAfterValid();
                }

                if (json.activeStep != -1) {
                    setPreviousStepIndex(props.activeStep);
                    props.setState({ activeStep: json.activeStep })
                }
            });
        }
    }

    const activeStep = props.render({ ...props.children[props.activeStep], context: fields });

    const contextState = {
        onFieldChange: (field) => {
            setFields({
                type: 'changeField',
                ...field
            });
        }
    }

    const stepContent = <div style={{ padding: '20px' }}>
        {activeStep}
        {valid ? <React.Fragment /> : <div style={{ color: 'red' }} id={props.id + "-validationError"}><UDIcon icon="Exclamation" /> {validationError}</div>}
        <div style={{ padding: '20px' }}>
            <Button
                disabled={props.activeStep === 0 || disablePrevious}
                onClick={handleBack}
                id={props.id + "btnPrev"}
            >
                {props.backButtonText}
            </Button>
            <Button variant="contained" color="primary" onClick={handleNext} id={props.id + "btnNext"}>
                {validating ?
                    <CircularProgress size={14} /> :
                    <Typography> {props.activeStep === props.children.length - 1 ? props.finishButtonText : props.nextButtonText}</Typography>}
            </Button>
        </div>
    </div>

    return (
        <FormContext.Provider value={contextState}>
            <Stepper activeStep={props.activeStep} id={props.id} orientation={props.orientation} className={props.className}>
                {props.children.map((step, index) => (
                    <Step key={step.label} >
                        <StepLabel error={!valid && index === props.activeStep}>{step.label}</StepLabel>
                        {props.orientation === "vertical" && index == props.activeStep ? <StepContent>{stepContent}</StepContent> : <React.Fragment />}
                    </Step>
                ))}
            </Stepper>
            {props.orientation === "horizontal" ? stepContent : <React.Fragment />}
        </FormContext.Provider>
    )
}

export const UDStepper = withComponentFeatures(UDStepperImpl);
export const UDStep = withComponentFeatures(UDStepImpl);