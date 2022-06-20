import React from 'react';
import IconButton from '@mui/material/IconButton';
import DarkIcon from '@mui/icons-material/Brightness7';
import LightIcon from '@mui/icons-material/Brightness4';
import { AppContext } from './../../app/app-context';

export default props => {
  return (
    <AppContext.Consumer>
      {context => {
        return (
          <IconButton
            {...props}
            onClick={e => {
              const next = context.theme === 'dark' ? 'light' : 'dark'
              localStorage.setItem('theme', next);
              context.setTheme(next)
            }}
            size="large">
            {context.theme === 'dark' ? <DarkIcon /> : <LightIcon />}
          </IconButton>
        );

      }}
    </AppContext.Consumer>
  );
}