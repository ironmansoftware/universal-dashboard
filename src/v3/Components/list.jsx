import Avatar from "@material-ui/core/Avatar";
import Collapse from "@material-ui/core/Collapse";
import Divider from "@material-ui/core/Divider";
import List from "@material-ui/core/List";
import ListItem from "@material-ui/core/ListItem";
import ListItemAvatar from "@material-ui/core/ListItemAvatar";
import ListItemIcon from "@material-ui/core/ListItemIcon";
import ListItemSecondaryAction from "@material-ui/core/ListItemSecondaryAction";
import ListItemText from "@material-ui/core/ListItemText";
import ListSubheader from "@material-ui/core/ListSubheader";
import { makeStyles } from "@material-ui/core/styles";
import ExpandLess from "@material-ui/icons/ExpandLess";
import ExpandMore from "@material-ui/icons/ExpandMore";
import React, { useState } from "react";
import classNames from "classnames"
import { withComponentFeatures } from 'universal-dashboard';

const useStyles = makeStyles(theme => ({
  root: {
    width: "100%"
  },
  item: {
    marginBottom: theme.spacing.unit
  }
}))

export const UDListItem = withComponentFeatures(props => {

  const [open, setOpen] = useState(false);

  var avatar = null;

  if (props.avatarType === 'Icon' && props.icon) 
  {
    avatar = <ListItemIcon>{props.icon ? props.render(props.icon) : null}</ListItemIcon>
  }

  if (props.avatarType === 'Avatar' && props.source)
  {
    avatar = <ListItemAvatar><Avatar src={props.source}/></ListItemAvatar>
  }

  var secondaryItem = null;
  if (props.secondaryItem)
  {
      secondaryItem = <ListItemSecondaryAction>{props.render(item.secondaryAction)}</ListItemSecondaryAction>
  }

  const onClick = () => {
    if (props.onClick) { props.onClick() }
    if (props.children) { setOpen(!open); }
  }

  var expand = null; 
  var collapse = null;
  if (props.children) 
  {
    expand = open ? <ExpandLess color="primary" /> : <ExpandMore color="primary" />;
    collapse = <Collapse in={open} timeout="auto" unmountOnExit mountOnEnter >
      <List component="div" disablePadding>
        {props.render(props.children)}
      </List>
      <Divider/>
    </Collapse>
  }

  return [
    <ListItem
      button={props.onClick !== null}
      key={props.id}
      id={props.id}
      onClick={onClick}
    >
      {avatar}
      <ListItemText primary={props.label} secondary={props.subTitle} />
      {secondaryItem}
      {expand}
    </ListItem>,
    collapse
  ];
})

export const UDList = withComponentFeatures(props => {
    const classes = useStyles();
    const { children } = props;

    return (
      <List
          id={props.id}
          key={props.id}
          subheader={
            <ListSubheader disableSticky>{props.subHeader}</ListSubheader>
          }
          className={classNames(classes.root, "ud-mu-list")}
          component="div"
        >
          {props.render(children)}
      </List>
    );
})