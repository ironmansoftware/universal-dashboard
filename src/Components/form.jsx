import React, { useState, useReducer, useEffect } from 'react';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import { withComponentFeatures } from 'universal-dashboard';
import makeStyles from '@mui/styles/makeStyles';
import UDIcon from './icon';

const defaultContext = {
    fields: {},
    onFieldChange: (field) => { },
    submit: () => { }
}

export const FormContext = React.createContext(defaultContext);

const useStyles = makeStyles(theme => ({
    formControlPadding: {
        padding: theme.spacing(1),
    },
    errorColor: {
        color: theme.palette.error.main
    }
}));


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

const UDForm = (props) => {

    const classes = useStyles();

    const [fields, setFields] = useReducer(reducer, {});
    const [valid, setValid] = useState(props.onValidate == null);
    const [canSubmit, setCanSubmit] = useState(props.onValidate == null);
    const [validationError, setValidationError] = useState("");
    const [content, setContent] = useState(props.children);
    const [hideSubmit, setHideSubmit] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    const validate = () => {
        props.onValidate(fields).then(x => {

            var json = JSON.parse(x);

            if (Array.isArray(json)) {
                json = json[0]
            }

            setValid(json.valid);
            setCanSubmit(json.valid);
            setValidationError(json.validationError);
        });
    }

    useEffect(() => {
        const token = props.subscribeToIncomingEvents(props.id, incomingEvent)
        return () => {
            props.unsubscribeFromIncomingEvents(token)
        }
    });

    var components = [];

    if (Object.keys(content).length > 0) {
        components = props.render(content);
    }

    if (!components.map) {
        components = [components];
    }

    const onPost = (data) => {
        return new Promise((resolve, reject) => {
            UniversalDashboard.post(`/api/internal/component/element/${props.id}?form=true`, data, (returnData) => {
                resolve(returnData)
            });
        });
    }

    const onSubmit = (validate) => {
        if (validate && !valid) {
            return;
        }

        setSubmitting(true);
        onPost(fields).then(x => {

            try {
                x = JSON.parse(x);
            }
            catch { }

            if (x && Object.keys(x).length > 0) {
                setContent(x);
                setHideSubmit(true);
            }
            setSubmitting(false);
        })
    }

    const incomingEvent = (type, event) => {
        if (type === "testForm" && props.onValidate) {
            validate();
        }

        if (type === "invokeMethod" && event.method === "invokeForm") {
            onSubmit(event.validate);
        }
    }

    if (props.onValidate) {
        useEffect(() => {
            validate();
        }, [fields]);
    }

    const contextState = {
        onFieldChange: (field) => {
            setFields({
                type: 'changeField',
                ...field
            });
        },
        submit: () => { if (canSubmit && !submitting && !hideSubmit && !props.disableSubmitOnEnter) { onSubmit() } }
    }

    if (submitting && props.loadingComponent) {
        return props.render(props.loadingComponent);
    }

    var submitButton = null;
    if (!hideSubmit) {
        submitButton = (
            <Grid item xs={6}>
                {valid ? <React.Fragment></React.Fragment> : <div className={classes.errorColor} id={props.id + "-validationError"}><UDIcon icon="Exclamation" /> {validationError}</div>}
                <Button variant={props.buttonVariant} onClick={onSubmit} disabled={!canSubmit} className={classes.formControlPadding}>{props.submitText}</Button>
            </Grid>
        )
    }

    var cancelButton = null;
    if (props.onCancel) {
        cancelButton = <Grid item xs={6}>
            <Button variant={props.buttonVariant} onClick={() => props.onCancel()} className={classes.formControlPadding}>{props.cancelText}</Button>
        </Grid>
    }

    if (submitting) {
        submitButton = (
            <Grid item xs={12}>
                <Button variant={props.buttonVariant} disabled={true} className={classes.formControlPadding}><UDIcon icon="Spinner" spin /> {props.submitText}</Button>
            </Grid>
        )
    }

    return (
        <div id={props.id}>
            <FormContext.Provider value={contextState}>
                <Grid container className={props.className}>
                    {components.map(x => <Grid item xs={12} className={classes.formControlPadding}>{x}</Grid>)}
                    {submitButton}
                    {cancelButton}
                </Grid>
            </FormContext.Provider>
        </div>
    )
}

export default withComponentFeatures(UDForm);