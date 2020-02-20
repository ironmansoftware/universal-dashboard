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
    const [content, setContent] = useState(props.content);

    if (props.content == null) props.content = content;

    useEffect(() => {
        if (props.endpoint) {
            UniversalDashboard.get("/api/internal/component/element/" + props.id, data => {
                if (data.error) {
                    setContent(data.error.message)
                    return;
                }
                setContent(data);
            });
        }
    }, [true])

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
                {UniversalDashboard.renderComponent(props.content)}
            </ExpansionPanelDetails>
        </ExpansionPanel>
        )
}

export default function ExpansionPanelGroup(props) {
    const classes = useStyles();
    
    var children = props.items.map(x => <UDExpansionPanel {...x} />);

    return (
        <div className={classes.root}>
            {children}
        </div>
    );
}