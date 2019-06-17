---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version:https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDButton.md
schema: 2.0.0
---

# New-UDButton

## SYNOPSIS
Creates a new button.

## SYNTAX

```
New-UDButton [[-Id] <String>] [[-Text] <Object>] [[-OnClick] <Object>] [-Floating] [-Flat]
 [[-Icon] <FontAwesomeIcons>] [[-IconAlignment] <String>] [[-BackgroundColor] <DashboardColor>]
 [[-FontColor] <DashboardColor>] [-Disabled] [<CommonParameters>]
```

## DESCRIPTION
Creates a new button. Buttons come in different shapes and sizes and can be configured to execute scripts when clicked. 

## EXAMPLES

### Raised Button
```powershell
New-UDButton -Text "Button" 
```

Creates a basic, raised button.

### Button with Icon
```powershell
New-UDButton -Text "Button" -Icon cloud
```

Creates a basic, raised button with an icon.

### Button Colors
```powershell
New-UDButton -Text "Button" -BackgroundColor "red" -FontColor "white"
```

Creates a red button with white text.

### Floating
```powershell
New-UDButton -Floating -Icon plus
```

Creates a circular, floating button with a plus icon.

### Flat
```powershell
New-UDButton -Flat -Text "Button"
```

Creates a flat button

### OnClick Event Handler
```powershell
New-UDButton -Text "Button" -OnClick {
    Show-UDToast -Message "Ouch!"
}
```

Creats a button that shows a toast message when clicked. 


## PARAMETERS

### -BackgroundColor
Background color of the button.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Disabled
Creates a disabled button.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Flat
Creates a flat button without shadows. 

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Floating
Creates a circular, floating button.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontColor
Font color of the button. This also changes the icon color.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Icon
The icon for this button.

```yaml
Type: FontAwesomeIcons
Parameter Sets: (All)
Aliases:
Accepted values: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconAlignment
The icon alignment. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: left, right

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of the component.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OnClick
An event handler that is called when the button is clicked. This can be either a ScriptBlock or a UDEndpoint.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Text
The test to display on the button.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
