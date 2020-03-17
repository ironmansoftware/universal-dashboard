/** @jsx jsx */
import React, {useEffect} from 'react';

import { makeStyles } from '@material-ui/core/styles';
import InputLabel from '@material-ui/core/InputLabel';
import Input from '@material-ui/core/Input';
import MenuItem from '@material-ui/core/MenuItem';
import ListSubheader from '@material-ui/core/ListSubheader';
import FormControl from '@material-ui/core/FormControl';
import Select from '@material-ui/core/Select';
import { withComponentFeatures } from './universal-dashboard';
import {FormContext} from './form';
import {jsx} from 'theme-ui'

const useStyles = makeStyles(theme => ({
  formControl: {
    margin: theme.spacing(1),
    minWidth: 120,
  },
}));

const UDSelectWithContext = (props) => {
    return (
        <FormContext.Consumer>
            {
                ({onFieldChange}) => <UDSelect {...props} onFieldChange={onFieldChange} />
            }
        </FormContext.Consumer>

    )
}

const UDSelect = (props) => {
    const classes = useStyles();
    const groups = props.options.filter(m => m.type === 'mu-select-group');

    const onChange = (event) => {
        props.onFieldChange({id: props.id, value : event.target.value})
        props.setState({ value : event.target.value})

        if (props.onChange) {
            props.onChange(event.target.value);
        }
    }

    let defaultValue = null;
    let options = [];
    if (groups.length > 0)
    {
        options = groups.map(x => {
            return [
                <ListSubheader>{x.name}</ListSubheader>,
                x.options.map(m => <MenuItem value={m.value}>{m.name}</MenuItem>)
            ]
        })
    }
    else 
    {
        defaultValue = props.defaultValue || props.options[0].value;
        options = props.options.map(x => <MenuItem value={x.value}>{x.name}</MenuItem>)

        if (props.multiple && !Array.isArray(defaultValue)) {
            defaultValue = [defaultValue];
        }

        if (!props.value) {
            props.setState({value: defaultValue})
        }
    }

    useEffect(() => {
        props.onFieldChange({id: props.id, value: defaultValue});
        return () => {}
    }, true)

    return (
        <FormControl className={classes.formControl} key={props.id} 
        //sx={{bg: 'background', color: 'text'}}
        >
            <InputLabel htmlFor={props.id}>{props.label}</InputLabel>
            <Select 
                defaultValue={defaultValue} 
                input={<Input id={props.id} />} 
                value={props.value} 
                onChange={event => onChange(event)}
                multiple={props.multiple}
            >
                {options}
            </Select>
        </FormControl>
    )
}

export default withComponentFeatures(UDSelectWithContext);