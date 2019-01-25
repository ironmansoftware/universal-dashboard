---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# New-UDChartLegendOptions

## SYNOPSIS
Legend options for a chart.

## SYNTAX

```
New-UDChartLegendOptions [-Hide] [[-Position] <String>] [[-FullWidth] <Boolean>] [-Reverse]
 [[-LabelBoxWidth] <Int32>] [[-LabelFontSize] <Int32>] [[-LabelFontStyle] <String>]
 [[-LabelFontFamily] <String>] [[-LabelPadding] <Int32>] [[-LabelUsePointStyle] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Legend options for a chart.

## EXAMPLES

### Example 1
```
PS C:\> $LegendOptions = New-UDChartLegendOptions -Position "bottom" 
PS C:\> $Options = New-UDChartOptions -LegendOptions $LegendOptions
```

Moves the legend to the bottom of the chart.

## PARAMETERS

### -FullWidth
Marks that this box should take the full width of the canvas (pushing down other boxes). This is unlikely to need to be changed in day-to-day use.

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

### -Hide
Hides the legend.

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

### -LabelBoxWidth
width of coloured box

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

### -LabelFontFamily
Font family of legend text.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LabelFontSize
font size of text

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

### -LabelFontStyle
font style of text

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: normal, bold, italic

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LabelPadding
Padding between rows of colored boxes.

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

### -LabelUsePointStyle
Label style will match corresponding point style (size is based on fontSize, boxWidth is not used in this case).

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Position
Position of the legend.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: top, bottom, left, right

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Reverse
Legend will show datasets in reverse order.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

