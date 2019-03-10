// This is in work in progress so don't use it!
import React, { Component, Fragment } from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import List from "@material-ui/core/List";
import ListItem from "@material-ui/core/ListItem";
import ListItemIcon from "@material-ui/core/ListItemIcon";
import ListItemSecondaryAction from "@material-ui/core/ListItemSecondaryAction";
import ListItemText from "@material-ui/core/ListItemText";
import ListSubheader from "@material-ui/core/ListSubheader";
import Zoom from "@material-ui/core/Zoom";
import { Paper, Button, Collapse } from "@material-ui/core";

const styles = theme => ({
  root: {
    width: "100%",
    height: "100%",
    flexGrow: 1
  },
  item: {
    marginBottom: theme.spacing.unit
  }
});

class UdExpandListItem extends Component {
  state = {
      open: false
  };

  handleClick = () => {
    this.setState({ open: true });
  };

  handleCloseClick = () => {
    this.setState({ open: false });
  };

  render() {
    const { classes } = this.props;
    return (
      <div className={classes.root}>
        {!this.state.open ? (
          <ListItem
            style={this.props.style}
            id={this.props.id}
            button
            onClick={this.handleClick}
            divider
          >
            <ListItemIcon>
              {this.props.icon
                ? UniversalDashboard.renderComponent(this.props.icon)
                : null}
            </ListItemIcon>
            <ListItemText
              inset
              primary={this.props.label}
              secondary={this.props.subTitle}
              style={!this.props.icon ? { marginLeft: "24px" } : null}
            />
          </ListItem>
        ) : (
          <Collapse unmountOnExit in={this.state.open} timeout={600}>
            <Paper >
                {UniversalDashboard.renderComponent(this.props.content)}
                <Button variant="flat" color="primary" onClick={this.handleCloseClick}>Close</Button>
            </Paper>
          </Collapse>
        )}
      </div>
    );
  }
}

UdExpandListItem.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(UdExpandListItem);
