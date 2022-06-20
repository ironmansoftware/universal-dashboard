import React from 'react';

const theme = sessionStorage.getItem('theme')

export const DefaultAppContext = { 
    theme: theme ? theme : 'light',
    setTheme: () => {}
} 

export const AppContext = React.createContext(DefaultAppContext);