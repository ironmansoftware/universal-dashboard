---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDBarChartOptions

## SYNOPSIS
Options specific to a bar chart.

## SYNTAX

```
New-UDBarChartOptions [[-LayoutOptions] <Object>] [[-LegendOptions] <Object>] [[-TitleOptions] <Object>]
 [[-TooltipOptions] <Object>] [[-xAxes] <Object>] [[-yAxes] <Object>] [[-BarPercentage] <Single>]
 [[-CategoryPercentage] <Single>] [[-BarThickness] <Int32>] [[-MaxBarThickness] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Options specific to a bar chart. Used with New-UDChart. 

## EXAMPLES

### Example 1
```
PS C:\>  $Options = New-UDBarChartOptions -LayoutOptions (
                New-UDChartLayoutOptions -Padding 15
            ) -LegendOptions (
                New-UDChartLegendOptions -Position "bottom" 
            ) 
            
 PS C:\>  New-UDChart -Title "Chart" -Id "Chart" -Type Bar -EndPoint { <#...#> } -Options $Options
```

## PARAMETERS

### -BarPercentage
Percent (0-1) of the available width each bar should be within the category width. 1.0 will take the whole category width and put the bars right next to each other.

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BarThickness
Manually set width of each bar in pixels. If not set, the base sample widths are calculated automatically so that they take the full available widths without overlap. Then, the bars are sized using barPercentage and categoryPercentage.

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

### -CategoryPercentage
Percent (0-1) of the available width each category should be within the sample width. 

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LayoutOptions
Layout options for this chart. Use New-UDChartLayoutOptions.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LegendOptions
Legend options for this chart. Use New-UDChartLegendOptions.

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

### -MaxBarThickness
Set this to ensure that bars are not sized thicker than this.

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

### -TitleOptions
Title options for this chart. Use New-UDChartTitleOptions.

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

### -TooltipOptions
Tooltip options for this chart. Use New-UDChartTooltipOptions.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -xAxes
The x-Axis for this chart. Use New-UDCategoryChartAxis, New-UDLinearChartAxis or New-UDLogarithmicChartAxis.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -yAxes
The y-Axis for this chart. Use New-UDCategoryChartAxis, New-UDLinearChartAxis or New-UDLogarithmicChartAxis.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
