import React, {useState, useRef} from 'react'
import Button from '@material-ui/core/Button'
import { withComponentFeatures } from 'universal-dashboard'
import { makeStyles } from '@material-ui/core/styles'
import CircularProgress from '@material-ui/core/CircularProgress';
import { FormContext } from './form';
import { Typography } from '@material-ui/core';

const useStyles = makeStyles((theme) => ({
    root: {
      '& > *': {
        margin: theme.spacing(1),
      },
    },
    input: {
      display: 'none',
    },
  }));

const UDUploadWithContext = (props) => {
    return (
        <FormContext.Consumer>
            {
                ({onFieldChange}) => <UDUpload {...props} onFieldChange={onFieldChange} />
            }
        </FormContext.Consumer>
    )
}


const UDUpload = props => {
  const classes = useStyles();

  const [loading, setLoading] = useState(false);
  const inputEl = useRef(null);

  const handleUpload = (e) => {
    var file = inputEl.current.files[0],
    reader = new FileReader();

    reader.onloadend = function () {
        var data = reader.result.replace(/^data:.+;base64,/, '');
        const value = { 
            name: file.name,
            type: file.type,
            data: data
        }
        props.setState({
            value: value
        })
        props.onFieldChange({id: props.id, value: value });

        if (props.onUpload) {
            props.onUpload(value);
        }

        setLoading(false);
    };

    setLoading(true);
    reader.readAsDataURL(file);
  }

  return (
    <div className={classes.root}>
        <input
            accept={props.accept}
            className={classes.input}
            id={props.id}
            type="file"
            ref={inputEl}
            onChange={handleUpload}
        />
        <label htmlFor={props.id}>
        <Button variant={props.variant} color={props.color} component="span">
            {loading ?
            <CircularProgress size={14} /> :
            <Typography>{props.text}</Typography>}
        </Button>
        </label>
    </div>
  )
}

export default withComponentFeatures(UDUploadWithContext)