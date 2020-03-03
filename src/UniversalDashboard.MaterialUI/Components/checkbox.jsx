/** @jsx jsx */
import React, {useEffect} from "react";
import Checkbox from "@material-ui/core/Checkbox";
import CheckBoxIcon from "@material-ui/icons/CheckBox"
import CheckBoxIconBlank from "@material-ui/icons/CheckBoxOutlineBlank"
import FormControlLabel from "@material-ui/core/FormControlLabel"
import classNames from "classnames";
import {FormContext} from './form';
import {withComponentFeatures} from './universal-dashboard';
import {jsx} from 'theme-ui'

const UDCheckboxWithContext = (props) => {
  return (
    <FormContext.Consumer>
      {
         ({onFieldChange}) => <UDCheckbox {...props} onFieldChange={onFieldChange} />
      }
    </FormContext.Consumer>
  );
}

const UDCheckbox = (props) => {
  const onChange = (event) => {
    props.onFieldChange({id: props.id, value: event.target.checked});

    props.setState({ checked : event.target.checked})

    if (props.onChange) {
        props.onChange(event.target.checked)
    }
  }

  useEffect(() => {
    props.onFieldChange({id: props.id, value: props.checked});
    return () => {}
  }, true)

  return (
    <FormControlLabel
    disabled={props.disabled}
      control={
        <Checkbox
          id={props.id}
          className={classNames(props.className, "ud-mu-checkbox")}
          checked={props.checked}
          onChange={(event) => onChange(event)}
          value={props.checked}
          style={!props.disabled ? { ...props.style } : {color: null}}
          color="default"
          icon={ props.icon ? props.render(props.icon) : <CheckBoxIconBlank/> }
          checkedIcon={ props.checkedIcon ? props.render(props.checkedIcon) :  <CheckBoxIcon/> }
          sx={{ color: 'primary' }}/>
      }
      label={!props.label ? null : props.label}
      labelPlacement={props.labelPlacement}
      />
  )
}

export default withComponentFeatures(UDCheckboxWithContext);