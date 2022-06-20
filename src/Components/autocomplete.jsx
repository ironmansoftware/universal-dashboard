import React, { useEffect, useState } from 'react';
import TextField from '@mui/material/TextField';
import Autocomplete from '@mui/material/Autocomplete';
import { FormContext } from './form';
import { withComponentFeatures } from 'universal-dashboard'
import throttle from 'lodash/throttle';
import InputAdornment from "@mui/material/InputAdornment";
import UDIcon from "./icon";


const UDAutocompleteWithContext = (props) => {
  return (
    <FormContext.Consumer>
      {
        ({ onFieldChange }) => <UDAutocomplete {...props} onFieldChange={onFieldChange} />
      }
    </FormContext.Consumer>
  )
}

function UDAutocomplete(props) {

  const [inputValue, setInputValue] = useState('');

  const onChange = (event, value) => {
    props.onFieldChange({ id: props.id, value: value })
    props.setState({ value: value })

    if (props.onChange) {
      props.onChange(value);
    }

    if (props.multiple) {
      setInputValue('');
    } else {
      setInputValue(value);
    }

  }

  var value = props.value;
  if (!value && props.multiple) {
    value = []
  }

  const onEnter = () => {
    if (props.onEnter) {
      props.onEnter();
    }
  }

  useEffect(() => {
    props.onFieldChange({ id: props.id, value: props.value })
    return () => { }
  }, true)

  if (!props.onLoadOptions) {
    return <Autocomplete
      id={props.id}
      onChange={onChange}
      onKeyUp={(e) => e.key === "Enter" && onEnter()}
      options={props.options}
      getOptionLabel={(option) => option}
      value={value}
      disablePortal
      fullWidth={props.fullWidth}
      multiple={props.multiple}
      renderInput={(params) => <TextField {...params} label={props.label} className={props.className} variant={props.variant} fullWidth InputProps={{
        ...params.InputProps,
        startAdornment: props.icon ? (
          <InputAdornment position="start">
            <UDIcon {...props.icon} />
          </InputAdornment>
        ) : null,
      }} />}
    />
  }

  const [options, setOptions] = useState([]);

  const fetch = React.useMemo(
    () =>
      throttle((request, callback) => {
        props.onLoadOptions(request).then(callback);
      }, 200),
    [],
  );

  React.useEffect(() => {
    let active = true;

    if (inputValue === '') {
      setOptions([]);
      return undefined;
    }

    fetch(inputValue, (results) => {
      if (active) {

        let json = JSON.parse(results);

        if (!Array.isArray(json)) {
          json = [json]
        }

        setOptions(json || []);
      }
    });

    return () => {
      active = false;
    };
  }, [inputValue, fetch]);

  if ((value === '' && !Array.isArray(value)) || !value) {
    value = []
  }
  else if (value && !Array.isArray(value)) {
    value = [value]
  }


  return (
    <Autocomplete
      id={props.id}
      //getOptionLabel={(option) => (typeof option === 'string' ? option : option.description)}
      filterOptions={(x) => x}
      options={options}
      autoComplete
      onChange={onChange}
      onKeyUp={(e) => e.key === "Enter" && onEnter()}
      inputValue={inputValue}
      includeInputInList
      value={value}
      multiple={props.multiple}
      fullWidth={props.fullWidth}
      renderInput={(params) => (
        <TextField
          {...params}
          InputProps={{
            ...params.InputProps,
            startAdornment: props?.icon ? (
              <InputAdornment position="start">
                <UDIcon {...props.icon} />
              </InputAdornment>
            ) : null,
          }}
          onChange={(event) => setInputValue(event.target.value)}
          label={props.label}
          variant={props.variant}
          fullWidth
          className={props.className}
        />
      )}
    />
  );
}

export default withComponentFeatures(UDAutocompleteWithContext);