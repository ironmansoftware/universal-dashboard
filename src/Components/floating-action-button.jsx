import React from 'react';
import makeStyles from '@mui/styles/makeStyles';
import Fab from '@mui/material/Fab';
var classNames = require('classnames');

function onClick(props) {
  if (props.onClick) {
    UniversalDashboard.publish('element-event', {
      type: "clientEvent",
      eventId: props.onClick,
      eventName: 'onChange',
      eventData: ''
    });
  }
}

export default function FloatingActionButton(props) {
  const useStyles = makeStyles(theme => ({
    root: {
      '& > *': {
        margin: theme.spacing(1),
      },
    },
    extendedIcon: {
      marginRight: theme.spacing(1),
    },
    fabRight: {
      position: 'absolute',
      bottom: theme.spacing(2),
      right: theme.spacing(2),
    },
    fabLeft: {
      position: 'absolute',
      bottom: theme.spacing(2),
      left: theme.spacing(2),
    },
  }));

  const classes = useStyles();

  var icon = null;
  if (props.icon) {
    icon = UniversalDashboard.renderComponent(props.icon)
  }

  let position = null;
  if (props.position === 'bottomright') {
    position = classes.fabRight;
  }

  if (props.position === 'bottomleft') {
    position = classes.fabLeft;
  }

  return (
    <div className={classNames(classes.root, props.className, position)}>
      <Fab sx={{ bg: 'primary', color: 'text' }} onClick={() => onClick(props)} size={props.size} id={props.id} color={props.themeColor}>
        {icon}
      </Fab>
    </div>
  );
}