import React from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import Paper from "@material-ui/core/Paper";

const styles = theme => ({
  root: {
    flexGrow: 1,
    display: "flex",
    padding: theme.spacing.unit * 2,
    margin: theme.spacing.unit
  }
});

export class UdPaper extends React.Component {
  state = {
    content: this.props.content,
    width: this.props.width,
    height: this.props.height,
    square: this.props.square,
    style: this.props.style,
    elevation: this.props.elevation
  };

  render() {
    const { classes } = this.props;

    var components = this.state.content.map(element => {
      if (element.type !== null) {
        return UniversalDashboard.renderComponent(element);
      } else {
        return <React.Fragment>{element}</React.Fragment>;
      }
    });

    return (
      <Paper id={this.props.id} className={classes.root} {...this.state}>
        {components}
      </Paper>
    );
  }
}

UdPaper.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(UdPaper);
