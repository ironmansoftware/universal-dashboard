import { base, bootstrap } from '@theme-ui/presets'
import { darken, lighten } from '@theme-ui/color'

export default {
  ...bootstrap,
  styles: {
    ...bootstrap,
  },
  colors: {
    text: '#333',
    background: '#fff',
    primary: '#90caf9',
    secondary: '#f48fb1',
    accent: '#609',
    modes: {
      dark: {
        text: '#fff',
        background: '#121212',
        primary: '#648dae',
        secondary: '#aa647b',
        accent: '#609',
        muted: '#111',
        error: '#d32f2f',
        warning: '#f57c00',
        info: '#1976d2',
        success: '#388e3c',
      },
      light: {
        text: '#333',
        background: '#fff',
        primary: '#90caf9',
        secondary: '#f48fb1',
        accent: '#609',
        muted: '#111',
        error: '#e57373',
        warning: '#ffb74d',
        info: '#64b5f6',
        success: '#81c784',
      },
      default: {
        text: '#333',
        background: '#fff',
        primary: '#90caf9',
        secondary: '#f48fb1',
        accent: '#609',
        muted: '#111',
        error: '#f44336',
        warning: '#ff9800',
        info: '#2196f3',
        success: '#4caf50',
      },
    },
  },
  layout: {
    header: {
      color: 'white',
      backgroundColor: 'primary',
    },
    footer: {
      color: 'text',
      backgroundColor: 'primary',
    },
  },
  forms: {
    checkbox: {
      color: 'primary',
      bg: 'primary',
      '::before': {
        content: '""',
        borderRight: 'primary',
        borderBottom: 'primary',
    },
      'input:checked ~ &': {
        color: 'bg',
        bg: 'primary',
        borderColor: 'primary',
      },
      'input:focus ~ &': {
        color: 'primary',
        bg: 'secondary',
      },
    },
  },
  buttons: {
    primary: {
      color: 'text',
      bg: 'primary',
      '&:hover': {
        bg: darken('primary', 0.45),
        color: lighten('primary', 0.45),
      },
    },
    secondary: {
      color: 'text',
      bg: 'secondary',
      '&:hover': {
        bg: darken('primary', 0.45),
        color: lighten('primary', 0.45),
      },
    },
  },
  styles: {
    root: {
      backgroundColor: 'background',
      color: 'text',
    },
  },
}
