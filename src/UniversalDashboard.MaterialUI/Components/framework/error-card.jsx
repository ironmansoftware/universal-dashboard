import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import Typography from '@material-ui/core/Typography';

const useStyles = makeStyles({
    root: {
      minWidth: 275,
    },
    bullet: {
      display: 'inline-block',
      margin: '0 2px',
      transform: 'scale(0.8)',
    },
    title: {
      fontSize: 14,
    },
    pos: {
      marginBottom: 12,
    },
  });

export default function ErrorCard(props) {

    const classes = useStyles();
    var icon = UniversalDashboard.renderComponent({type: 'icon', icon:'ExclamationTriangle', color: 'red'})

    return (
        <Card id={props.id}>
            <CardContent>
                <Typography className={classes.title} color="textSecondary" gutterBottom>
                {props.title}
                </Typography>
                <Typography variant="h4" component="h2">
                    {icon} {props.message}
                </Typography>
                <Typography variant="h5" component="h2">
                    {props.location}
                </Typography>
            </CardContent>
        </Card>
    )
}