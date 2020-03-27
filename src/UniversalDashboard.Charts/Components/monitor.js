  import React, { lazy } from 'react'
import { MonitorProvider } from './api/MonitorState'
import Monitor from './instance'
import ToolBar from './parts/toolbar'

const MonitorLayout = lazy(() =>
  import(/* webpackChunkName: 'MonitorLayout' */ './parts/monitorLayout'),
)
const SettingsPanel = lazy(() =>
  import(/* webpackChunkName: 'SettingsPanel' */ './parts/settingsPanel'),
)
const Title = lazy(() =>
  import(/* webpackChunkName: 'Title' */ './parts/title'),
)
const Description = lazy(() =>
  import(/* webpackChunkName: 'Description' */ './parts/description'),
)


export default ({ title, description, ...props }) => {
  return (
    <MonitorProvider>
      <SettingsPanel />
      <MonitorLayout>
        <ToolBar />
        <Title title={title} />
        <Description description={description} />
        <Monitor {...props} />
      </MonitorLayout>
    </MonitorProvider>
  )
}
