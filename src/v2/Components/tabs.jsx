import React, { useEffect, useState } from 'react';
import { TabBar, Tab } from '@rmwc/tabs'

const TabPanel = ({ content, ...props }) => {
    return <div style={{display: props.display }}>{UniversalDashboard.renderComponent(content)}</div>
}

const TabContainer = props => {
    const { tabs } = props
    const [activeTabIndex, setActiveTabIndex] = useState(0)
    const [activeTabPanel, setActiveTabPanel] = useState(tabs[0])

    const refreshTabPanel = (id, tab) => {
        UniversalDashboard.get(`/api/internal/component/element/${id}`, data => {
            setActiveTabPanel({ ...tab, content: data })
        })
    }

    return (
        <div>
            <TabBar
                activeTabIndex={activeTabIndex}
                onActivate={evt => setActiveTabIndex(evt.detail.index)}
            >
                {
                    tabs.map(tab => <Tab
                        id={tab.id}
                        label={tab.label}
                        stacked={tab.icon && tab.stacked || undefined}
                        onInteraction={evt => tab.refreshWhenActive && tab.isEndpoint ? refreshTabPanel(evt.detail.tabId, tab) : setActiveTabPanel(tab)}
                        icon={tab.icon && UniversalDashboard.renderComponent(tab.icon)} />
                    )
                }
            </TabBar>
            {
                props.renderOnClick ? 

                <TabPanel {...activeTabPanel} display="block"/>

                :

                tabs.map(tab => {
                    let display = activeTabPanel.id === tab.id ? "block" : "none"
                    return <TabPanel {...tab} display={display} />
                })
            }
            
        </div>
    )
}

export default TabContainer

