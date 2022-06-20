import React, { useEffect, useState } from "react";
import { withComponentFeatures } from "universal-dashboard";
import TextField from "@mui/material/TextField";
import { FormContext } from "./form";
import UDIcon from "./icon";
import InputAdornment from "@mui/material/InputAdornment";
import MaskedInput from "react-text-mask";
import { FormControl, FormHelperText, Input, InputLabel } from "@mui/material";

const UDTextFieldWithContext = (props) => {
  return (
    <FormContext.Consumer>
      {({ onFieldChange, submit }) => (
        <UDTextField {...props} onFieldChange={onFieldChange} submit={submit} />
      )}
    </FormContext.Consumer>
  );
};

const UDTextField = (props) => {
  const onChange = (e) => {
    props.setState({ value: e.target.value })
  }

  const propsMask = props?.mask || null;
  const TextMaskCustom = React.useCallback((props) => {
    const { inputRef, ...other } = props;
    const mask = Array.isArray(propsMask)
      ? propsMask.map((x) =>
        x.startsWith("/") && x.endsWith("/")
          ? new RegExp(x.substr(1, x.length - 2))
          : x
      )
      : [];
    return (
      <MaskedInput
        {...other}
        ref={(ref) => {
          inputRef(ref ? ref.inputElement : null);
        }}
        //autoFocus
        mask={mask}
        placeholderChar={"\u2000"}
        showMask
      />
    );
  }, [propsMask])

  useEffect(() => {
    props.onFieldChange({ id: props.id, value: props.value })
  }, [props.value])

  const onEnter = () => {
    props.submit();
    if (props.onEnter) {
      props.onEnter();
    }
  }

  return props?.mask ? (
    <FormControl>
      <InputLabel htmlFor={props?.id}>{props?.label}</InputLabel>
      <Input
        {...props}
        value={props?.value}
        onChange={onChange}
        startAdornment={
          props?.icon ? (
            <InputAdornment position="start">
              <UDIcon {...props.icon} />
            </InputAdornment>
          ) : null
        }
        name="textmask"
        id={props?.id}
        inputComponent={TextMaskCustom}
      />
      {props?.helperText && (
        <FormHelperText id={props?.id}>{props?.helperText}</FormHelperText>
      )}
    </FormControl>
  ) : (
    <TextField
      {...props}
      type={props.textType}
      onChange={onChange}
      onKeyUp={(e) => e.key === "Enter" && !props.multiline && onEnter()}
      InputLabelProps={{
        shrink: props?.value || props?.label,
      }}
      InputProps={{
        startAdornment: props?.icon ? (
          <InputAdornment position="start">
            <UDIcon {...props.icon} />
          </InputAdornment>
        ) : null,
      }}
    />
  );
};

export default withComponentFeatures(UDTextFieldWithContext);
