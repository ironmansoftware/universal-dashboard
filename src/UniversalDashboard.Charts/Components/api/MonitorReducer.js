import React from 'react'
import { Global } from 'viser-react'
import { useThemeUI } from 'theme-ui'

export function testLight() {
  const context = useThemeUI()
  const { theme, colorMode } = context

  console.group('theme')
  console.log('mode', colorMode)
  console.log('theme', theme)
  console.groupEnd()

  return theme.chart.light
}

export function testDark() {
  const context = useThemeUI()
  const { theme, colorMode } = context

  console.group('theme')
  console.log('mode', colorMode)
  console.log('theme', theme)
  console.groupEnd()

  return theme.chart.dark
}

const initialState = {
  running: true,
  theme: {
    title: 'light',
  },
  data: [],
  url: '',
  settings: {
    visible: false,
    statistics: {
      showMin: false,
      showAvg: false,
      showMax: false,
      showCurrent: false,
    },
    refreshInterval: '5s',
    timeRange: 'none',
    chartType: 'area',
    chartLineStyle: 'sharp',
  },
}

const monitorReducer = (state, action) => {
  switch (action.type) {
    case 'STATUS_CHANGE': {
      return { ...state, running: action.payload }
    }
    case 'LOAD_DATA': {
      return { ...state, data: action.payload }
    }
    case 'EXPORT_DATA': {
      return { ...state }
    }
    case 'THEME_CHANGE': {
      if (action.payload.title === 'light') {
        Global.setTheme(testLight())
      } else {
        Global.setTheme(testDark())
      }
      return {
        ...state,
        theme: {
          title: action.payload.title,
        },
      }
    }
    case 'SET_CHART_TYPE': {
      return {
        ...state,
        settings: { ...state.settings, chartType: action.payload.chartType },
      }
    }
    case 'SET_CHART_LINE_TYPE': {
      return {
        ...state,
        settings: {
          ...state.settings,
          chartLineStyle: action.payload.chartLineStyle,
        },
      }
    }
    case 'SET_REFRESH_INTERVAL': {
      return {
        ...state,
        running: action.payload === 'off' ? false : true,
        settings: { ...state.settings, refreshInterval: action.payload },
      }
    }
    case 'SET_TIME_RANGE': {
      return {
        ...state,
        settings: { ...state.settings, timeRange: action.payload },
      }
    }
    case 'SET_SETTINGS_VISIBILITY': {
      return {
        ...state,
        settings: { ...state.settings, visible: action.payload },
      }
    }
    case 'SET_SETTINGS_SHOW_MIN': {
      return {
        ...state,
        settings: {
          ...state.settings,
          statistics: { ...state.settings.statistics, showMin: action.payload },
        },
      }
    }
    case 'SET_SETTINGS_SHOW_AVG': {
      return {
        ...state,
        settings: {
          ...state.settings,
          statistics: { ...state.settings.statistics, showAvg: action.payload },
        },
      }
    }
    case 'SET_SETTINGS_SHOW_MAX': {
      return {
        ...state,
        settings: {
          ...state.settings,
          statistics: { ...state.settings.statistics, showMax: action.payload },
        },
      }
    }
    default:
      return state
  }
}

export { initialState }
export default monitorReducer
