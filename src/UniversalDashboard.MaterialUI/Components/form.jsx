import React, {useState, useReducer, useEffect} from 'react';
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import { withComponentFeatures } from './universal-dashboard';
import { makeStyles } from '@material-ui/core/styles';
import UDIcon from './icon';

const defaultContext = {
    fields: {},
    onFieldChange: (field) => {}
}

export const FormContext = React.createContext(defaultContext);

const useStyles = makeStyles(theme => ({
    formControlPadding: {
      padding: theme.spacing(1),
    },
  }));


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

const UDForm = (props) => {

    const classes = useStyles();

    const [fields, setFields] = useReducer(reducer, {});
    const [valid, setValid] = useState(props.onValidate == null);
    const [validationError, setValidationError] = useState("");
    const [content, setContent] = useState(props.children);
    const [hideSubmit, setHideSubmit] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    var components = [];
    
    if (Object.keys(content).length > 0)
    {
        components = props.render(content);
    }
    
    if (!components.map)
    {
        components = [components];
    }

    const onSubmit = () => {
        setSubmitting(true);
        props.onSubmit(fields).then(x => {
            if (x && Object.keys(x).length > 0) {
                setContent(x);
                setHideSubmit(true);
            }
            setSubmitting(false);
        })
    }

    if (props.onValidate)
    {
        useEffect(() => {
            props.onValidate(fields).then(x => {

                var json = JSON.parse(x);

                if (Array.isArray(json))
                {
                    json = json[0]
                }

                setValid(json.valid);
                setValidationError(json.validationError);
            });
        }, [fields]);
    }
    
    const contextState = {
        onFieldChange: (field) => {
            setFields({
                type: 'changeField',
                ...field
            });
        }
    }

    if (submitting && props.loadingComponent) {
        return props.render(props.loadingComponent);
    }

    var submitButton = null;
    if (!hideSubmit) {
        submitButton = (
            <Grid item xs={12}>
                {valid ? <React.Fragment></React.Fragment> : <div style={{color: 'red'}} id={props.id + "-validationError"}><UDIcon icon="Exclamation" /> {validationError}</div>}
                <Button onClick={onSubmit} disabled={!valid} className={classes.formControlPadding}>Submit</Button>
            </Grid>
        )
    }

    if (submitting) {
        submitButton = (
            <Grid item xs={12}>
                <Button disabled={true} className={classes.formControlPadding}><UDIcon icon="Spinner" spin/> Submit</Button>
            </Grid>
        )
    }

    return (
        <div id={props.id}>
            <FormContext.Provider value={contextState}>
                <Grid container>
                    {components.map(x => <Grid item xs={12} className={classes.formControlPadding}>{x}</Grid>)}
                    {submitButton}
                </Grid>
            </FormContext.Provider>
        </div>
    )
}

export default withComponentFeatures(UDForm);