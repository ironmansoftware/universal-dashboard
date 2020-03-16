import React, { createContext, useReducer, useContext } from "react"
import monitorReducer, { initialState } from './MonitorReducer'

const Context = createContext()

export function MonitorProvider({ children }) {
  const value = useReducer(monitorReducer, initialState)
  return <Context.Provider value={value} children={children} />
}

export function useMonitor() {
  return useContext(Context)
}