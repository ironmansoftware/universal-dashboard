import Avatar from "@mui/material/Avatar";
import Collapse from "@mui/material/Collapse";
import Divider from "@mui/material/Divider";
import List from "@mui/material/List";
import ListItem from "@mui/material/ListItem";
import ListItemAvatar from "@mui/material/ListItemAvatar";
import ListItemIcon from "@mui/material/ListItemIcon";
import ListItemSecondaryAction from "@mui/material/ListItemSecondaryAction";
import ListItemText from "@mui/material/ListItemText";
import ListSubheader from "@mui/material/ListSubheader";
import makeStyles from '@mui/styles/makeStyles';
import ExpandLess from "@mui/icons-material/ExpandLess";
import ExpandMore from "@mui/icons-material/ExpandMore";
import React, { useState } from "react";
import classNames from "classnames"
import { withComponentFeatures } from 'universal-dashboard';

const useStyles = makeStyles(theme => ({
  root: {
    width: "100%"
  },
  item: {
    marginBottom: theme.spacing()
  },
  nested: {
    paddingLeft: theme.spacing(4),
  },
}))

export const UDListItem = withComponentFeatures(props => {
  const classes = useStyles();
  const [open, setOpen] = useState(props.open);

  var avatar = null;

  if (props.avatarType === 'Icon' && props.icon) {
    avatar = <ListItemIcon>{props.icon ? props.render(props.icon) : null}</ListItemIcon>
  }

  if (props.avatarType === 'Avatar' && props.source) {
    avatar = <ListItemAvatar><Avatar src={props.source} /></ListItemAvatar>
  }

  var secondaryItem = null;
  if (props.secondaryItem) {
    secondaryItem = <ListItemSecondaryAction>{props.render(item.secondaryAction)}</ListItemSecondaryAction>
  }

  const onClick = () => {
    if (props.onClick) { props.onClick() }
    if (props.children) { setOpen(!open); }
  }

  var expand = null;
  var collapse = null;
  if (props.children) {
    expand = open ? <ExpandLess color="primary" /> : <ExpandMore color="primary" />;
    collapse = <Collapse in={open} timeout="auto" unmountOnExit mountOnEnter >
      <List component="div" disablePadding>
        {props.render(props.children)}
      </List>
      <Divider />
    </Collapse>
  }

  return [
    <ListItem
      button={props.onClick !== null}
      key={props.id}
      id={props.id}
      onClick={onClick}
      className={classNames(props.className, props.nested && classes.nested)}
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
      className={classNames(classes.root, "ud-mu-list", props.className)}
      component="div"
    >
      {props.render(children)}
    </List>
  );
})