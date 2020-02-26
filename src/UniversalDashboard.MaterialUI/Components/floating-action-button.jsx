import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Fab from '@material-ui/core/Fab';
import Icon from './icon';

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
      }));

      const classes = useStyles();

      var icon = null; 
      if (props.icon) {
          icon = <Icon icon={props.icon}/>
      }

      return (
        <div className={classes.root}>
          <Fab sx={{ bg: 'primary', color: 'text' }} onClick={() => onClick(props)} size={props.size} id={props.id}>
             {icon}
          </Fab>
        </div>
      );
}