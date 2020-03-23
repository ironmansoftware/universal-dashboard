import React from 'react'
import light from '../theme/light'
import dark from '../theme/dark'
import { Global } from 'viser-react'
import { AreaChartOutlined, LineChartOutlined } from '@ant-design/icons'

const ChartTypeIcon = () => {
  return initialState.settings.chartType === "area" 
  ? <span><AreaChartOutlined style={{ color: initialState.theme.props.defaultColor }}/> Area chart</span>
  : <span><LineChartOutlined style={{ color: initialState.theme.props.defaultColor }}/> Line chart</span>
}

Global.registerTheme('dark', dark)
Global.registerTheme('light', light)

const initialState = {
  running: true,
  theme: {
    title: 'light',
    props: light,
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
    chartTypeSelector: <ChartTypeIcon />,
    chartType: 'area',
    chartLineStyle: 'sharp'
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
        Global.setTheme(light)
      } else {
        Global.setTheme(dark)
      }
      return {
        ...state,
        theme: {
          title: action.payload.title,
          props: action.payload.title === 'light' ? light : dark,
        },
      }
    }
    case 'SET_CHART_TYPE': {
      return {
        ...state,
        settings: { ...state.settings, chartType: action.payload.chartType },
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
      return { ...state, settings: { ...state.settings, statistics: {...state.settings.statistics, showMin: action.payload }} }
    }
    case 'SET_SETTINGS_SHOW_AVG': {
      return { ...state, settings: { ...state.settings, statistics: {...state.settings.statistics, showAvg: action.payload }} }
    }
    case 'SET_SETTINGS_SHOW_MAX': {
      return { ...state, settings: { ...state.settings, statistics: {...state.settings.statistics, showMax: action.payload }} }
    }
    default:
      return state
  }
}



export { initialState }
export default monitorReducer
