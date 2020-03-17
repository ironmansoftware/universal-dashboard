import React from 'react'
import light from '../theme/light'
import dark from '../theme/dark'
import { Global } from 'viser-react'
import { AreaChartOutlined } from '@ant-design/icons'


Global.registerTheme('dark', dark)
Global.registerTheme('udLight', light)



const initialState = {
  running: true,
  theme: {
    title: 'udLight',
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
    chartTypeSelector: <span><AreaChartOutlined style={{ color: "inherit" }}/> Area chart</span>,
    chartType: 'area',
    chartLineStyle: 'regular'
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
      if (action.payload.title === 'udLight') {
        Global.setTheme(light)
      } else {
        Global.setTheme(dark)
      }
      return {
        ...state,
        theme: {
          title: action.payload.title,
          props: action.payload.title === 'udLight' ? light : dark,
        },
      }
    }
    case 'SET_CHART_TYPE': {
      return {
        ...state,
        settings: { ...state.settings, chartTypeSelector: action.payload.chartTypeSelector, chartType: action.payload.chartType },
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
    case 'STATISTIC_CHANGE': {
      return { ...state }
    }
    default:
      return state
  }
}

export { initialState }
export default monitorReducer
