import React from 'react';
import Paper from '@mui/material/Paper';
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
var classNames = require('classnames');

import { useTheme } from '@mui/material/styles';

import makeStyles from '@mui/styles/makeStyles';

const useStyles = makeStyles(theme => ({
    root: {
        flexGrow: 1,
        backgroundColor: theme.palette.background.paper,
        display: 'flex'
    },
    tabs: {
        borderRight: `1px solid ${theme.palette.divider}`,
    },
}));

const TabPanel = (props) => {
    return (
        <div style={{ display: props.display, width: '100%' }}>{UniversalDashboard.renderComponent(props.content)}</div>
    )
}

const UDTabs = (props) => {
    const classes = useStyles();

    var { tabs } = props
    const [value, setValue] = React.useState(0);
    const [activeTabPanel, setActiveTabPanel] = React.useState({});

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };

    if (props.renderOnClick && activeTabPanel.value !== value) {
        const tab = props.tabs[value];
        if (tab.dynamic) {
            UniversalDashboard.get(`/api/internal/component/element/${tab.id}`, data => {
                setActiveTabPanel({ ...tab, content: data, value })
            })
        }
        else {
            setActiveTabPanel({ ...tab, value });
        }
    }

    const root = props.orientation === 'vertical' ? classes.root : "";
    const tabsClass = props.orientation === 'vertical' ? classes.tabs : "";

    if (!Array.isArray(tabs)) {
        tabs = [tabs]
    }

    return (
        <div id={props.id} key={props.id} className={root}>
            <Paper square>
                <Tabs
                    value={value}
                    indicatorColor="primary"
                    textColor="primary"
                    onChange={handleChange}
                    orientation={props.orientation}
                    className={classNames(tabsClass, props.className)}
                    centered={props.centered}
                    variant={props.variant}
                    scrollButtons={props.scrollButtons}
                >
                    {tabs.map(tab => <Tab label={tab.label} id={tab.id} disabled={tab.disabled} icon={UniversalDashboard.renderComponent(tab.icon)} />)}
                </Tabs>
            </Paper>
            {
                props.renderOnClick ?
                    <TabPanel key={value} {...activeTabPanel} display="block" /> :
                    tabs.map((tab, i) => {
                        let display = value == i ? "block" : "none"
                        return <TabPanel {...tab} display={display} />
                    })
            }
        </div>
    );
}

export default UDTabs;