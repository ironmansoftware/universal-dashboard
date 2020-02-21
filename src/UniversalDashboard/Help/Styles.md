# Styling Component using the new theme option 

### Style external component

_Setp 01_

in your webpack file add new external entry

```js
externals: {
    ...
    '@theme-ui/core': 'themeuicore'
},
```

this will let you import the necessary functions for styling the component.

---

_Step 02_

### Add import statement

add the custom `/** @jsx jsx */` pragma comment to the top of your module and import the jsx function

```js
/** @jsx jsx */
...
import { jsx } from '@theme-ui/core'
```

---

_Step 03_

### Custom the component using the theme variables

here is example of styling the button component using the buttons variable in our theme

we are using the ```sx``` property to add our style

## The Javascript file
```jsx
<Button
  onClick={this.onClick.bind(this)}
  id={this.props.id}
  flat={this.state.flat}
  disabled={this.state.disabled}
  floating={this.state.floating}
  sx={{ variant: `buttons.${this.props.variant}` }}
>
  {icon}
  {this.state.text}
</Button>
```

## The Powershell file

```ps
function New-UDButton {
    param(
        ...
        [Parameter()]
        [ValidateSet("primary","secondary")]
        [string]$Variant
    )
    end{
        ...
        variant = $Variant
    }
}
```

## Command in use

This will create new button with primary color in our dashboard.
```ps
New-UDButton -Text "Demo" -Variant primary
```
