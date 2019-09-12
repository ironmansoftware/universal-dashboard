---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# New-UDSplitPane

## SYNOPSIS

Creates a split pane between two controls that you can adjust the size of.

## SYNTAX

```
New-UDSplitPane [[-Id] <String>] [-Content] <ScriptBlock> [[-Direction] <String>] [[-MinimumSize] <Int32>]
 [[-DefaultSize] <Int32>]
```

## DESCRIPTION

Creates a split pane between two controls that you can adjust the size of.

## EXAMPLES

### Vertical Pane

```
New-UDSplitPane -Content {
    New-UDCard -Title 'Side 1' -Content {}
    New-UDCard -Title 'Side 2' -Content {}
}
```

Creates a vertical split pane. 

### Horizontal Pane

```
New-UDSplitPane -Content {
    New-UDCard -Title 'Side 1' -Content {}
    New-UDCard -Title 'Side 2' -Content {}
} -Direction horizontal
```

Creates a horizontal split pane. 

## PARAMETERS

### -Content

The controls to create the split pane for. This is should contain exactly two controls.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultSize

The default size in pixels of the top or left component.

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

### -Direction

Whether you want a split panel that is vertical or horizontal

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: vertical, horizontal

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id

Id of the split pane. 

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

### -MinimumSize

Minimum size in pixels of the panes. 

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

