import { useThemeUI, useColorMode } from 'theme-ui'
import light from '../theme/light'
import dark from '../theme/dark'
import { Global } from 'viser-react'
import { useMonitor } from '../api/MonitorState' 

export function getData(id) {
    let result = UniversalDashboard.get(`/api/internal/component/element/${id}`, data => {
    if (data.error) console.log(data.error)
    return data
  })

  if(!result) return null
  return result
}

export function getTheme() {
  const context = useThemeUI()
  const { theme } = context
  const chartTheme = theme.charts
  return chartTheme
}

export function getColorMode() {
  const [colorMode, setColorMode] = useColorMode()
  return colorMode
}

export function setChartTheme() {
    const [state, dispatch] = useMonitor()
    const { theme } = state
    const mode = getColorMode()
    if(mode === 'light'){
        dispatch({ type: "THEME_CHANGE", payload: { mode: 'light', title: 'udLight', props: light}})    
        // Global.setTheme('udLight')
    } 
    else{
        dispatch({ type: "THEME_CHANGE", payload: { mode: 'dark', title: 'udDark', props: dark}})
        // Global.setTheme('udDark')
    }
    console.log('theme',theme)
    // return theme.title  
}
