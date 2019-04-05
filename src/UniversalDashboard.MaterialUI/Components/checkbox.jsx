import React from "react";
import Checkbox from "@material-ui/core/Checkbox";
import CheckBoxIcon from "@material-ui/icons/CheckBox"
import CheckBoxIconBlank from "@material-ui/icons/CheckBoxOutlineBlank"
import FormControlLabel from "@material-ui/core/FormControlLabel"
import classNames from "classnames";

export default class UDCheckbox extends React.Component {
  state = {
    [this.props.id]: this.props.checked
  };

  onChangeEvent = (id,event) => {
    this.setState({ [id]: event.target.checked });
    UniversalDashboard.publish("element-event", {
      type: "clientEvent",
      eventId: id + "onChange",
      eventName: "",
      eventData: ""
    });
  };

  render(){
      return (
        <FormControlLabel
          disabled={this.props.disabled}
          control={
            <Checkbox
              id={this.props.id}
              className={classNames(this.props.className, "ud-mu-checkbox")}
              checked={this.state[this.props.id]}
              onChange={this.onChangeEvent.bind(this, this.props.id)}
              value={this.props.id}
              style={!this.props.disabled ? { ...this.props.style } : {color: null}}
              color="default"
              icon={
                !this.props.icon ? <CheckBoxIconBlank/> : UniversalDashboard.renderComponent(this.props.icon)
              }
              checkedIcon={
                !this.props.checkedIcon
                  ? <CheckBoxIcon/>
                  : UniversalDashboard.renderComponent(this.props.checkedIcon)
              }/>
          }
          label={!this.props.label ? null : this.props.label}
          labelPlacement={this.props.labelPlacement}
        />
      );
  }
}
