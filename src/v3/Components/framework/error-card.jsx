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

    var records = null;
    if (!Array.isArray(props.errorRecords))
    {
        records = <Typography>Unknown error occurred</Typography>
    } 
    else 
    {
      records = props.errorRecords.map(x => {
        return (
          <React.Fragment>
             <Typography>
                 {x.message}
             </Typography>
             <pre>
                 {x.location}
             </pre>
          </React.Fragment>
        )
     })
    }

    return (
        <Card id={props.id}>
            <CardContent>
                <Typography className={classes.title} color="textSecondary" gutterBottom>
                  {icon}   {props.title ? props.title : "One or more errors occurred"}
                </Typography>
                {records}
            </CardContent>
        </Card>
    )
}