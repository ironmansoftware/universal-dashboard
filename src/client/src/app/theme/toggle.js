/** @jsx jsx */
import { jsx } from '@theme-ui/core'
import { useColorMode  } from '@theme-ui/color-modes'
import {Button} from '@theme-ui/components'

const modes = [
  'light',
  'dark',
  'default',
]

export default props => {
  const [mode, setMode] = useColorMode()
  return (
    <Button
      {...props}
      variant="primary"
      children="Switch Color Mode"
      onClick={e => {
        const index = modes.indexOf(mode)
        const next = modes[(index + 1) % modes.length]
        setMode(next)
      }}
    />
  )
}
