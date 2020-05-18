/** @jsx jsx */
import { jsx, useColorMode } from 'theme-ui'
import IconButton from '@material-ui/core/IconButton';
import DarkIcon from '@material-ui/icons/Brightness7';
import LightIcon from '@material-ui/icons/Brightness4';

export default props => {
  const [ mode, setMode ] = useColorMode()
  return (
    <IconButton
      {...props}
      onClick={e => {
        const next = mode === 'dark' ? 'light' : 'dark'
        setMode(next)
      }}
    >
        {mode === 'dark' ? <DarkIcon/> : <LightIcon />}
    </IconButton>
  )
}