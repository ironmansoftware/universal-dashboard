---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDCategoryChartAxis

## SYNOPSIS
Creates options for a category chart axis. Used with chart options.

## SYNTAX

```
New-UDCategoryChartAxis [[-Position] <String>] [[-Offset] <Boolean>] [[-Id] <String>] [[-Labels] <String[]>]
 [[-Minimum] <Int32>] [[-Maximum] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Creates options for a category chart axis. Used with chart options.

## EXAMPLES

### Example 1
```
PS C:\> New-UDCategoryChartAxis -Labels @('January', 'February', 'March', 'April', 'May', 'June')
```

Creates a category chart axis with labels for January, February, March, April, May and June.

## PARAMETERS

### -Id
The ID of the axis. This can should be referenced with the dataset using the axis. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Labels
An array of labels to display.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Maximum
The maximum item to display.

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

### -Minimum
The minimum item to display.

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

### -Offset
If true, extra space is added to the both edges and the axis is scaled to fit into the chart area. This is set to true in the bar chart by default.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Position
Position of the axis in the chart. Possible values are: 'top', 'left', 'bottom', 'right'

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: left, right, top, bottom

Required: False
Position: 0
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
