import React from 'react';
import makeStyles from '@mui/styles/makeStyles';
import Card from '@mui/material/Card';
import CardActions from '@mui/material/CardActions';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import UDIcon from '../../app/ud-icon';

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
  var icon = <UDIcon icon="exclamationTriangle" />

  var records = null;
  if (!Array.isArray(props.errorRecords)) {
    records = <Typography>Unknown error occurred</Typography>
  }
  else {
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