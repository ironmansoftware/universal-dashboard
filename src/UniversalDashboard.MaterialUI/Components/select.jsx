import React, {useState, useEffect} from 'react';

import { makeStyles } from '@material-ui/core/styles';
import InputLabel from '@material-ui/core/InputLabel';
import Input from '@material-ui/core/Input';
import MenuItem from '@material-ui/core/MenuItem';
import ListSubheader from '@material-ui/core/ListSubheader';
import FormControl from '@material-ui/core/FormControl';
import Select from '@material-ui/core/Select';
import { withComponentFeatures } from './universal-dashboard';

const useStyles = makeStyles(theme => ({
  formControl: {
    margin: theme.spacing(1),
    minWidth: 120,
  },
}));

const UDSelect = (props) => {
    const classes = useStyles();
    const groups = props.options.filter(m => m.type === 'mu-select-group');

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

        if (!props.value) {
            props.setState({value: defaultValue})
        }
    }

    return (
        <FormControl className={classes.formControl} key={props.id}>
            <InputLabel htmlFor={props.id}>{props.label}</InputLabel>
            <Select defaultValue={defaultValue} input={<Input id={props.id} />} value={props.value} onChange={event => props.setState({ value : event.target.value})}>
                {options}
            </Select>
        </FormControl>
    )
}

export default withComponentFeatures(UDSelect);