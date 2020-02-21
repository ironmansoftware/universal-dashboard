import React from 'react';
import Paper from '@material-ui/core/Paper';
import Tabs from '@material-ui/core/Tabs';
import Tab from '@material-ui/core/Tab';

import { makeStyles, useTheme } from '@material-ui/core/styles';

const TabPanel = (props) => {
    return (
        <div style={{display: props.display }}>{UniversalDashboard.renderComponent(props.content)}</div>
    )
}

const UDTabs = (props) => {
    const theme = useTheme();    

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

    return (
        <div id={props.id} key={props.id}>
            <Paper square>
                <Tabs
                    value={value}
                    indicatorColor="primary"
                    textColor="primary"
                    onChange={handleChange}
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