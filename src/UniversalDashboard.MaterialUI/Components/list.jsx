import React, { Component, Fragment } from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import List from "@material-ui/core/List";
import ListItem from "@material-ui/core/ListItem";
import ListItemAvatar from "@material-ui/core/ListItemAvatar";
import ListItemIcon from "@material-ui/core/ListItemIcon";
import ListItemSecondaryAction from "@material-ui/core/ListItemSecondaryAction";
import ListItemText from "@material-ui/core/ListItemText";
import ListSubheader from "@material-ui/core/ListSubheader";
import ExpandLess from "@material-ui/icons/ExpandLess";
import ExpandMore from "@material-ui/icons/ExpandMore";
import Collapse from "@material-ui/core/Collapse";

const styles = theme => ({
  root: {
    width: "100%",
  },
  item: {
    border: '1px solid #c9c9c9',
    marginBottom: theme.spacing.unit,
  }
});

class UdList extends Component {
  state = {};

  handleClick = event => {
    this.setState({ [event]: !this.state[event] });
  };

  handleItemClick = props => {
    UniversalDashboard.publish("element-event", {
      type: "clientEvent",
      eventId: props.id + "onClick",
      eventName: "",
      eventData: ""
    });
  };

  //   Render Basic list Item
  renderListitem = (props) => {
    return (
      <ListItem
        button={!props.isButton ? false : true}
        key={props.id}
        onClick={
          props.isButton ? this.handleItemClick.bind(this, props) : null
        }
      >
        <ListItemIcon>
          {props.icon ? UniversalDashboard.renderComponent(props.icon) : null}
        </ListItemIcon>
        <ListItemText inset primary={props.label} secondary={props.subTitle} />
        {props.secondaryAction ? (
          <ListItemSecondaryAction>
            {UniversalDashboard.renderComponent(props.secondaryAction)}
          </ListItemSecondaryAction>
        ) : null}
      </ListItem>
    );
  };

  //   Render Nested List Item With Collapse Option
  renderNestedListItem = (props) => {
    return (
      <Fragment>
        {props.content == null
          ? this.renderListitem(props)
          : props.content.map(item => {
              return (
                <Fragment>
                  <ListItem
                    key={props.id}
                    button={!props.isButton ? false : true}
                    onClick={this.handleClick.bind(this, props.label)}
                  >
                    <ListItemIcon>
                      {props.icon
                        ? UniversalDashboard.renderComponent(props.icon)
                        : null}
                    </ListItemIcon>
                    <ListItemText
                      inset
                      primary={props.label}
                      secondary={props.subTitle}
                    />
                    {this.state[props.label] ? (
                      <ExpandLess color="default" />
                    ) : (
                      <ExpandMore color="default" />
                    )}
                    {props.secondaryAction ? (
                      <ListItemSecondaryAction>
                        {UniversalDashboard.renderComponent(
                          props.secondaryAction
                        )}
                      </ListItemSecondaryAction>
                    ) : null}
                  </ListItem>

                  <Collapse
                    in={this.state[props.label]}
                    timeout="auto"
                    unmountOnExit
                  >
                    <List component="div" key={item.id}>
                      {item.content == null
                        ? this.renderListitem(item)
                        : this.renderNestedListItem(item)}
                    </List>
                  </Collapse>
                </Fragment>
              );
            })}
      </Fragment>
    );
  };

  render() {
    const { classes } = this.props;
    return (
      <List className={classes.root} component="div">
        {this.props.content.map(item => {
          return this.renderNestedListItem(item);
        })}
      </List>
    );
  }
}

UdList.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(UdList);
