import React from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import Button from "@material-ui/core/Button";
import UdMuIcon from "./icon";

const styles = theme => ({
  button: {
    margin: theme.spacing.unit
  },
  leftIcon: {
    marginRight: theme.spacing.unit
  },
  rightIcon: {
    marginLeft: theme.spacing.unit
  }
});

export class UdButton extends React.Component {

  handleClick = () => {
    UniversalDashboard.publish("element-event", {
      type: "clientEvent",
      eventId: this.props.id + "onClick",
      eventName: "",
      eventData: ""
    });
  };

  render() {
    const { classes } = this.props;

    var icon = this.props.icon ? (
      <UdMuIcon
        {...this.props.icon}
        style={
          this.props.iconAlignment === "left"
            ? { marginRight: 8 }
            : { marginLeft: 8 }
        }
      />
    ) : null

    return (
      <Button
        variant={this.props.variant}
        size={this.props.size}
        disabled={this.props.disabled}
        className={classes.button}
        fullWidth={this.props.fullWidth}
        href={this.props.href}
        onClick={this.handleClick.bind(this)}
        style={{ ...this.props.style }}
        id={this.props.id}
      >
        {this.props.iconAlignment === "left" ? icon : null}
        {this.props.text}
        {this.props.iconAlignment === "right" ? icon : null}
      </Button>
    );
  }
}

UdButton.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles, { withTheme: true })(UdButton);
