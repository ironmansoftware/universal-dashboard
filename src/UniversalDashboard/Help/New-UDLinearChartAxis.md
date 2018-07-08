---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# New-UDLinearChartAxis

## SYNOPSIS
The linear scale is use to chart numerical data. It can be placed on either the x or y axis. The scatter chart type automatically configures a line chart to use one of these scales for the x axis. As the name suggests, linear interpolation is used to determine where a value lies on the axis.

## SYNTAX

```
New-UDLinearChartAxis [[-Position] <String>] [[-Offset] <Boolean>] [[-Id] <String>] [[-BeginAtZero] <Boolean>]
 [[-Minimum] <Int32>] [[-Maximum] <Int32>] [[-MaxTickLimit] <Int32>] [[-StepSize] <Int32>]
 [[-SuggestedMaximum] <Int32>] [[-SuggestedMinimum] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The linear scale is use to chart numerical data. It can be placed on either the x or y axis. The scatter chart type automatically configures a line chart to use one of these scales for the x axis. As the name suggests, linear interpolation is used to determine where a value lies on the axis.

## EXAMPLES

## PARAMETERS

### -BeginAtZero
if true, scale will include 0 if it is not already included.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -MaxTickLimit
Maximum number of ticks and gridlines to show.

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

### -Maximum
User defined maximum number for the scale, overrides maximum value from data.

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
User defined minimum number for the scale, overrides minimum value from data.

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

### -StepSize
User defined fixed step size for the scale.

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

### -SuggestedMaximum
Adjustment used when calculating the maximum data value.

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

### -SuggestedMinimum
Adjustment used when calculating the minimum data value.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

