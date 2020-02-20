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

    const handleChange = (event, newValue) => {
        setValue(newValue);
    };

    return (
        <div>
            <Paper square>
                <Tabs
                    value={value}
                    indicatorColor="primary"
                    textColor="primary"
                    onChange={handleChange}
                >
                    {tabs.map(tab => <Tab label={tab.label} />)}
                </Tabs>
            </Paper>
            {tabs.map((tab, i) => {
                let display = value == i ? "block" : "none"
                return <TabPanel {...tab} display={display}/>
            })}
        </div>
    );
}

export default UDTabs;