/** @jsx jsx */
import { jsx } from '@theme-ui/core'
import { useColorMode  } from '@theme-ui/color-modes'

export default props => {
  const [mode, setMode] = useColorMode()
  return (
    <button
      {...props}
      children="Switch Color Mode"
      onClick={e => {
        const next = mode === 'dark' ? 'light' : 'dark'
        setMode(next)
      }}
    />
  )
}
