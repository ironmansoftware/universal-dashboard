import React, {useState, useEffect} from 'react';
import Stepper from '@material-ui/core/Stepper';
import Step from '@material-ui/core/Step';
import StepLabel from '@material-ui/core/StepLabel';
import Button from '@material-ui/core/Button';
import { withComponentFeatures } from './universal-dashboard';
import Skeleton from '@material-ui/lab/Skeleton';

const UDStepImpl = (props) => {

    const [content, setContent] = useState(null);

    useEffect(() => {
        props.onLoad({}).then(x => {
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
    const handleNext = () => {
        props.setState({ activeStep : props.activeStep + 1})
    };

    const handleBack = () => {
        props.setState({ activeStep : props.activeStep - 1})
    };

    const activeStep = props.render(props.children[props.activeStep]);

    return (
        <div>
            <Stepper activeStep={props.activeStep}>
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
                    >
                    Back
                </Button>
                <Button variant="contained" color="primary" onClick={handleNext}>
                    {props.activeStep === props.children.length - 1 ? 'Finish' : 'Next'}
                </Button>
                </div>  
            </div>
        </div>
    )
}

export const UDStepper = withComponentFeatures(UDStepperImpl);
export const UDStep = withComponentFeatures(UDStepImpl);