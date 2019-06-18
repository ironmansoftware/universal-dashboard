---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version:https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDGridLayout.md
schema: 2.0.0
---

# New-UDGridLayout

## SYNOPSIS
Layout components using a JSON-based grid system.

## SYNTAX

```
New-UDGridLayout [[-Id] <String>] [[-RowHeight] <Int32>] [[-Content] <ScriptBlock>] [[-Layout] <String>]
 [[-LargeColumns] <Int32>] [[-MediumColumns] <Int32>] [[-SmallColumns] <Int32>] [[-ExtraSmallColumns] <Int32>]
 [[-ExtraExtraSmallColumns] <Int32>] [[-LargeBreakpoint] <Int32>] [[-MediumBreakpoint] <Int32>]
 [[-SmallBreakpoint] <Int32>] [[-ExtraSmallBreakpoint] <Int32>] [[-ExtraExtraSmallBreakpoint] <Int32>]
 [-Draggable] [-Resizable] [-Persist] [<CommonParameters>]
```

## DESCRIPTION
Layout components using a JSON-based grid system. This uses the react-grid-layout component: https://github.com/strml/react-grid-layout#features 

If you are using Enterprise, you can use the -Design flag on Start-UDDashboard to drag and drop components.

## EXAMPLES

### Grid Layout
```powershell
New-UDGridLayout -Layout "[
      {i: 'a', x: 0, y: 0, w: 1, h: 2, static: true},
      {i: 'b', x: 1, y: 0, w: 3, h: 2, minW: 2, maxW: 4},
      {i: 'c', x: 4, y: 0, w: 1, h: 2}
    ]" -Content {
        New-UDCard -BackgroundColor black -Id a 
        New-UDCard -BackgroundColor black -Id b
        New-UDCard -BackgroundColor black -Id c
    }
```

Lays out the cards using the specified JSON layout.

## PARAMETERS

### -Content
Content of the layout. 

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Draggable
Whether the components are draggable. 

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

### -ExtraExtraSmallBreakpoint

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExtraExtraSmallColumns

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExtraSmallBreakpoint

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExtraSmallColumns

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of this component.

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

### -LargeBreakpoint

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LargeColumns

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Layout
The JSON layout for this component.

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

### -MediumBreakpoint

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MediumColumns

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Persist
Whether to persist the layout in the user's browser local storage. 

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

### -Resizable
Whether the grid is resizable.

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

### -RowHeight

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SmallBreakpoint

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SmallColumns

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
