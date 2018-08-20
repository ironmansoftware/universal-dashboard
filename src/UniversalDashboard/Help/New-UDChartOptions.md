---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDChartOptions

## SYNOPSIS
Options for a chart.

## SYNTAX

```
New-UDChartOptions [[-LayoutOptions] <Object>] [[-LegendOptions] <Object>] [[-TitleOptions] <Object>]
 [[-TooltipOptions] <Object>] [[-xAxes] <Object>] [[-yAxes] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Options for a chart. Use with New-UDChart.

## EXAMPLES

### Example 1
```
PS C:\> $Options = New-UDChartOptions -LayoutOptions (
                New-UDChartLayoutOptions -Padding 15
            )
PS C:\> New-UDChart -Options $Options #...
```

Creates a chart and specifies padding options for it. 

## PARAMETERS

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
