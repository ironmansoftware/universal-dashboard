import React from 'react';
import IconButton from '@material-ui/core/IconButton';
import DarkIcon from '@material-ui/icons/Brightness7';
import LightIcon from '@material-ui/icons/Brightness4';
import {AppContext} from './../../app/app-context';

export default props => {
  return (
    <AppContext.Consumer>
      {context => {
        return (
            <IconButton
            {...props}
            onClick={e => {
              const next = context.theme === 'dark' ? 'light' : 'dark'
              sessionStorage.setItem('theme', next);
              context.setTheme(next)
            }}
          >
              {context.theme === 'dark' ? <DarkIcon/> : <LightIcon />}
          </IconButton>
        )

      }}
    </AppContext.Consumer>

  )
}