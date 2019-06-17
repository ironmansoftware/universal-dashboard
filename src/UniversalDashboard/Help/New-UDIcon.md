---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard
online version: https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDIcon.md
schema: 2.0.0
---

# New-UDIcon

## SYNOPSIS
Create icon from the FontAwesome pack

## SYNTAX

```
New-UDIcon [[-Id] <String>] [[-Icon] <FontAwesomeIcons>] [-FixedWidth] [-Inverse] [[-Rotation] <Int32>]
 [[-ClassName] <String>] [[-Transform] <String>] [[-Flip] <String>] [[-Pull] <String>] [-ListItem] [-Spin]
 [-Border] [-Pulse] [[-Size] <String>] [[-Style] <Hashtable>] [[-Title] <String>] [-Regular]
 [<CommonParameters>]
```

## DESCRIPTION
This command will generate an svg icon from the FontAwesome library, this icons comes from the Solid,Brand and regular packages.
The library include 1300+ icons.

## EXAMPLES

### Example 1
```powershell
New-UDIcon -Icon box -Style @{color = '#000'} -Id 'test-icon-button' 
```

Create icon with the default size sm and it has black color.

### Example 2
```powershell
New-UDIcon -Icon spinner -Size 3x -Style @{color = '#000'} -Id 'test-icon-button' -Spin
```

Create icon that has spin animation.

### Example 3
```powershell
New-UDIcon -Icon angry -Size 3x -Style @{color = '#000'} -Id 'test-icon-button' -Regular
```

Create angey icon that have a size of 3 and black color, and also this icon is from the FontAwesome regular pack ( semi light ) style.

## PARAMETERS

### -Border
set square border around the icon

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

### -ClassName
Add custom css class name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FixedWidth
 set the icons to the same fixed width

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

### -Flip
Flip horizontally, vertically, or both

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: horizontal, vertical, both

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Icon
{{Fill Icon Description}}

```yaml
Type: FontAwesomeIcons
Parameter Sets: (All)
Aliases:
Accepted values: 
Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Set css id property

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

### -Inverse
{{Fill Inverse Description}}

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

### -ListItem
{{Fill ListItem Description}}

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

### -Pull
{{Fill Pull Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: right, left

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Pulse
Use this to have the icon to rotate with 8 steps

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

### -Regular
This switch if define will search the icon in the FontAwesome regular pack, if the icon is not in the regular pack the command will used the fallback icon in the solid pack.

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

### -Rotation
Wil rotate the icon by 90 degress 

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Size
Set the size of the icon

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: xs, sm, lg, 2x, 3x, 4x, 5x, 6x, 7x, 8x, 9x, 10x

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Spin
Will spin the icon like loading animation

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

### -Style
Set css attributes on the icon like color etc...

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
{{Fill Title Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Transform
Thanks to the power of SVG in Font Awesome 5, you can scale, position, flip, & rotate icons arbitrarily using the data-fa-transform element attribute. You can even combine them for some super-useful effects.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
