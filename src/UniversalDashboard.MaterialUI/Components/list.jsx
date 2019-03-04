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
import Divider from "@material-ui/core/Divider";
import { Avatar } from "@material-ui/core";

const styles = theme => ({
  root: {
    width: "100%"
  },
  item: {
    marginBottom: theme.spacing.unit
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
  renderListItem = item => {
    return (
      <ListItem
        button={item.isButton !== true ? false : true}
        key={item.id}
        onClick={
          item.isButton === true ? this.handleItemClick.bind(this, item) : null
        }
        style={item.style}
        
      >
          {
            item.icon ? <ListItemIcon>
              {item.icon ? UniversalDashboard.renderComponent(item.icon) : null}
            </ListItemIcon> : (item.avatarSource ? <ListItemAvatar>
              <Avatar src={item.avatarSource}/>
            </ListItemAvatar> : null)
          }

        <ListItemText inset primary={item.label} secondary={item.subTitle} style={!item.icon ? {marginLeft:'24px'}: null} />

        {item.secondaryAction ? (
          <ListItemSecondaryAction>
            {UniversalDashboard.renderComponent(item.secondaryAction)}
          </ListItemSecondaryAction>
        ) : null}
      </ListItem>
    );
  };

  //   Render Nested List Item With Collapse Option
  renderNestedItem = item => {
    return item.content == null ? (
      this.renderListItem(item)
    ) : (
      <>
        {/* Top list item with collapse option */}
        <ListItem
          style={item.style}
          id={item.id}
          button
          onClick={this.handleClick.bind(this, item.label)}
        >
          {
            item.icon ? <ListItemIcon>
              {item.icon ? UniversalDashboard.renderComponent(item.icon) : null}
            </ListItemIcon> : (item.avatarSource ? <ListItemAvatar>
              <Avatar src={item.avatarSource}/>
            </ListItemAvatar> : null)
          }
          <ListItemText inset primary={item.label} secondary={item.subTitle} style={(!item.icon ? {marginLeft:'24px'}: null)} primaryTypographyProps={{...item.labelStyle}} />
          {this.state[item.label] ? (
            <ExpandLess color="primary" />
          ) : (
            <ExpandMore color="primary" />
          )}
        </ListItem>

        {/* The Content of the collapse element should be basic list item or nested */}
        <Collapse in={this.state[item.label]} timeout="auto" unmountOnExit>
          <List component="div" disablePadding>
            {item.content == null
              ? this.renderListItem(item)
              : item.content.map(nestedItem => {
                  return this.renderNestedItem(nestedItem);
                })}
          </List>
          <Divider/>
        </Collapse>
      </>
    );
  };

  render() {
    const { classes } = this.props;
    return (
      <List
        id={this.props.id}
        subheader={
          <ListSubheader disableSticky>{this.props.subHeader}</ListSubheader>
        }
        className={classes.root}
        component="div"
        style={this.props.style}
        
      >
        {this.props.content.map(item => {
          return this.renderNestedItem(item);
        })}
      </List>
    );
  }
}

UdList.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(UdList);
