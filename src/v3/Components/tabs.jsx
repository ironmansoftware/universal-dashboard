import React from 'react';
import Paper from '@material-ui/core/Paper';
import Tabs from '@material-ui/core/Tabs';
import Tab from '@material-ui/core/Tab';

import { makeStyles, useTheme } from '@material-ui/core/styles';

const useStyles = makeStyles(theme => ({
    root: {
      flexGrow: 1,
      backgroundColor: theme.palette.background.paper,
      display: 'flex',
      height: 224,
    },
    tabs: {
      borderRight: `1px solid ${theme.palette.divider}`,
    },
  }));

const TabPanel = (props) => {
    return (
        <div style={{display: props.display }}>{UniversalDashboard.renderComponent(props.content)}</div>
    )
}

const UDTabs = (props) => {  
    const classes = useStyles();

    const { tabs } = props
    const [value, setValue] = React.useState(0);
    const [activeTabPanel, setActiveTabPanel] = React.useState({});

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };

    if (props.renderOnClick && activeTabPanel.value !== value)
    {
        const tab = props.tabs[value];
        if (tab.dynamic)
        {
            UniversalDashboard.get(`/api/internal/component/element/${tab.id}`, data => {
                setActiveTabPanel({ ...tab, content: data, value })
            })
        }
        else 
        {
            setActiveTabPanel({...tab, value});
        }
    }

    const root = props.orientation === 'vertical' ? classes.root : "";
    const tabsClass = props.orientation === 'vertical' ? classes.tabs : "";

    return (
        <div id={props.id} key={props.id} className={root}>
            <Paper square>
                <Tabs
                    value={value}
                    indicatorColor="primary"
                    textColor="primary"
                    onChange={handleChange}
                    orientation={props.orientation}
                    className={tabsClass}
                >
                    {tabs.map(tab => <Tab label={tab.label} id={tab.id}/>)}
                </Tabs>
            </Paper>
            {
                props.renderOnClick ? 
                <TabPanel key={value} {...activeTabPanel} display="block"/> :
                tabs.map((tab, i) => {
                    let display = value == i ? "block" : "none"
                    return <TabPanel {...tab} display={display}/>
                })
            }
        </div>
    );
}

export default UDTabs;