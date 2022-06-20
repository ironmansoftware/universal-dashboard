import React, { useState, useEffect } from 'react';

import makeStyles from '@mui/styles/makeStyles';
import Accordion from '@mui/material/Accordion';
import AccordionSummary from '@mui/material/AccordionSummary';
import AccordionDetails from '@mui/material/AccordionDetails';
import Typography from '@mui/material/Typography';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import UDIcon from './icon';
import classNames from "classnames"
import { css } from 'emotion';

const useStyles = makeStyles(theme => ({
    root: {
        width: '100%',
        display: 'block'
    },
    heading: {
        fontSize: theme.typography.pxToRem(15),
        fontWeight: theme.typography.fontWeightRegular,
    },
}));

function UDExpansionPanel(props) {
    const classes = useStyles();
    const style = css(".MuiExpansionPanelDetails-root { display: block !important");

    const [expanded, setExpanded] = React.useState(props.active);

    return (
        <Accordion key={props.id} id={props.id} expanded={expanded} className={classNames(classes.root, style, props.className)}>
            <AccordionSummary
                expandIcon={<ExpandMoreIcon />}
                id={props.id}
                onClick={() => setExpanded(!expanded)}
            >
                {props.icon && !props.icon.icon && <UDIcon icon={props.icon} style={{ margin: '5px' }} />}
                {props.icon && props.icon.icon && UniversalDashboard.renderComponent(props.icon)}
                <Typography className={classes.heading}>{props.title}</Typography>
            </AccordionSummary>
            <AccordionDetails>
                {UniversalDashboard.renderComponent(props.children)}
            </AccordionDetails>
        </Accordion>
    )
}

export default function AccordionGroup(props) {
    const classes = useStyles();

    var children = null;
    if (Array.isArray(props.children)) {
        children = props.children.map(x => <UDExpansionPanel {...x} />);
    }
    else {
        children = <UDExpansionPanel {...props.children} />
    }

    return (
        <div className={classes.root}>
            {children}
        </div>
    );
}