---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# New-UDLogarithmicChartAxis

## SYNOPSIS
The logarithmic scale is use to chart numerical data. It can be placed on either the x or y axis. As the name suggests, logarithmic interpolation is used to determine where a value lies on the axis.

## SYNTAX

```
New-UDLogarithmicChartAxis [[-Position] <String>] [[-Offset] <Boolean>] [[-Id] <String>] [[-Minimum] <Int32>]
 [[-Maximum] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The logarithmic scale is use to chart numerical data. It can be placed on either the x or y axis. As the name suggests, logarithmic interpolation is used to determine where a value lies on the axis.

## EXAMPLES

## PARAMETERS

### -Id
The ID is used to link datasets and scale axes together. 

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

### -Maximum
User defined maximum number for the scale, overrides maximum value from data.

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

### -Minimum
User defined minimum number for the scale, overrides minimum value from data.

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
Position of the axis in the chart. 

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

