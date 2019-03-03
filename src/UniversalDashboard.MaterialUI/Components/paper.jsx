import React from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import Paper from "@material-ui/core/Paper";

const styles = theme => ({
  root: {
    flexGrow: 1,
    padding: theme.spacing.unit * 2,
    margin: "auto"
  }
});

export class UdPaper extends React.Component {
  state = {
    content: this.props.content,
    width: this.props.width,
    height: this.props.height,
    square: this.props.square
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
      <Paper
        square={this.state.square}
        className={classes.root}
        elevation={2}
        style={{ width: this.state.width, height: this.state.height }}
      >
        {components}
      </Paper>
    );
  }
}

UdPaper.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(UdPaper);