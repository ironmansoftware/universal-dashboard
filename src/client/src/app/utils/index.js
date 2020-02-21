import { getApiPath } from 'config'

const base = getApiPath()

export function loadJavascript(url, onLoad) {
  let jsElm = document.createElement('script')
  jsElm.onload = onLoad
  jsElm.type = 'application/javascript'
  jsElm.src = url
  document.body.appendChild(jsElm)
}

export function useFramework() {
  loadJavascript(`${base}/api/internal/javascript/framework`)
}

export function loadTheme() {
  let udTheme = document.createElement('link')
  udTheme.rel = 'stylesheet'
  udTheme.type = 'text/css'
  udTheme.media = 'screen'
  udTheme.href = `${base}/api/internal/dashboard/theme`
  document.getElementsByTagName('head')[0].appendChild(udTheme)
}

export const loadpluginRoutes = () => UniversalDashboard.provideRoutes()
export const loadPlugin = () => loadJavascript(`${base}/api/internal/javascript/plugin`)