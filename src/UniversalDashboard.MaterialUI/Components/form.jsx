import React, {useState, useReducer} from 'react';
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import { withComponentFeatures } from './universal-dashboard';
import { makeStyles } from '@material-ui/core/styles';

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
        onFieldChange: (field) => {
            setFields({
                type: 'changeField',
                ...field
            });
        }
    }

    return (
        <div id={props.id}>
            <FormContext.Provider value={contextState}>
                <Grid container>
                    {components.map(x => <Grid item xs={12} className={classes.formControlPadding}>{x}</Grid>)}
                    <Grid item xs={12}>
                        <Button onClick={onSubmit} disabled={!valid} className={classes.formControlPadding}>Submit</Button>
                    </Grid>
                </Grid>
            </FormContext.Provider>
        </div>
    )
}

export default withComponentFeatures(UDForm);
