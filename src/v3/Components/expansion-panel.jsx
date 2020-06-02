import React, {useState, useEffect} from 'react';

import { makeStyles } from '@material-ui/core/styles';
import ExpansionPanel from '@material-ui/core/ExpansionPanel';
import ExpansionPanelSummary from '@material-ui/core/ExpansionPanelSummary';
import ExpansionPanelDetails from '@material-ui/core/ExpansionPanelDetails';
import Typography from '@material-ui/core/Typography';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';
import UDIcon from './icon';

const useStyles = makeStyles(theme => ({
    root: {
      width: '100%',
    },
    heading: {
      fontSize: theme.typography.pxToRem(15),
      fontWeight: theme.typography.fontWeightRegular,
    },
  }));

function UDExpansionPanel(props) {
    const classes = useStyles();
    
    return (
        <ExpansionPanel key={props.id} id={props.id}>
            <ExpansionPanelSummary
            expandIcon={<ExpandMoreIcon />}
            id={props.id}
            >
                {props.icon && <UDIcon icon={props.icon} style={{margin: '5px'}}/>}
                <Typography className={classes.heading}>{props.title}</Typography>
            </ExpansionPanelSummary>
            <ExpansionPanelDetails>
                {UniversalDashboard.renderComponent(props.children)}
            </ExpansionPanelDetails>
        </ExpansionPanel>
        )
}

export default function ExpansionPanelGroup(props) {
    const classes = useStyles();

    var children = null;
    if (Array.isArray(props.children))
    {
        children = props.children.map(x => <UDExpansionPanel {...x} />);
    }
    else 
    {
        children = <UDExpansionPanel {...props.children} />
    }
    
    return (
        <div className={classes.root}>
            {children}
        </div>
    );
}