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
import { Avatar, CssBaseline } from "@material-ui/core";
import ReactInterval from "react-interval";


const styles = theme => ({
  root: {
    width: "100%"
  },
  item: {
    marginBottom: theme.spacing.unit
  }
});

class UdList extends Component {

  state = {
    content: this.props.content,
  };

  handleClick = event => {
    this.setState({ [event]: !this.state[event] });
  };

  handleItemClick = (item) => {
    UniversalDashboard.publish("element-event", {
      type: "clientEvent",
      eventId: item.id + "onClick",
      eventName: "",
      eventData: ""
    });
  };

  onLoadData = () => {
    UniversalDashboard.get(`/api/internal/component/element/${this.props.id}`,(data) =>{
      data.error ?
      this.setState({
        hasError: true,
        error: data.error,
        data: data,
        errorMessage: data.error.message
      }) :
      this.setState({
        content: data
      })
    })
  }

  componentWillMount = () => {
    if(this.props.isEndpoint){
      this.onLoadData()
    }
    this.pubSubToken = UniversalDashboard.subscribe(
      this.props.id,
      this.onIncomingEvent.bind(this)
    );
  };

  onIncomingEvent(eventName, event) {
    if (event.type === "syncElement") {
      this.onLoadData();
    }
  }

  componentWillUnmount() {
    UniversalDashboard.unsubscribe(this.pubSubToken);
  }

  //   Render Basic list Item
  renderListItem = item => {

    return (
      <ListItem
        button={item.isButton}
        key={item.id}
        id={item.id}
        onClick={
          item.onClick !== null ? this.handleItemClick.bind(this,item) : item.onClick
        }
        style={item.style}>

          {item.avatarType === 'Icon' ? <ListItemIcon>
              {item.icon ? UniversalDashboard.renderComponent(item.icon) : null}
            </ListItemIcon> : (item.avatarType === 'Avatar' ? <ListItemAvatar>
              <Avatar src={item.source}/>
            </ListItemAvatar> : null)}

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
          key={item.id}
          button
          onClick={this.handleClick.bind(this, item.label)}
        >
          {
            item.avatarType === 'Icon' ? <ListItemIcon>
              {item.icon ? UniversalDashboard.renderComponent(item.icon) : null}
            </ListItemIcon> : (item.avatarType === 'Avatar' ? <ListItemAvatar>
              <Avatar src={item.source}/>
            </ListItemAvatar> : null)
          }
          <ListItemText inset primary={item.label} secondary={item.subTitle} style={(!item.icon || !item.source ? {marginLeft:'24px'}: null)} primaryTypographyProps={{...item.labelStyle}} />
          {this.state[item.label] ? (
            <ExpandLess color="primary" />
          ) : (
            <ExpandMore color="primary" />
          )}
        </ListItem>

        {/* The Content of the collapse element should be basic list item or nested */}
        <Collapse in={this.state[item.label]} timeout="auto" unmountOnExit mountOnEnter>
          <List component="div" disablePadding>
            {item.content == null
              ? this.renderListItem(item)
              : (item.content.map(nestedItem => {
                  return nestedItem.type === 'mu-list-item' ?
                  this.renderNestedItem(nestedItem) : UniversalDashboard.renderComponent(nestedItem)
                }))}
          </List>
          <Divider/>
        </Collapse>
      </>
    );
  };

  render() {
    const { 
      classes, 
      autoRefresh,
      refreshInterval,
      isEndpoint 
    } = this.props;

    const { content } = this.state;

    return (
      <>
      <CssBaseline />
      <List
        id={this.props.id}
        key={this.props.id}
        subheader={
          <ListSubheader disableSticky>{this.props.subHeader}</ListSubheader>
        }
        className={classes.root}
        component="div"
        style={this.props.style}
      >
        {content.map(item => {
          return this.renderNestedItem(item);
        })}
      </List>
      <ReactInterval
        timeout={refreshInterval * 1000}
        enabled={autoRefresh}
        callback={this.onLoadData}
      />

      </>
    );
  }
}

UdList.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(UdList);
