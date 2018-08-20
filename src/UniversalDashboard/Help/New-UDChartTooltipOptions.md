---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDChartTooltipOptions

## SYNOPSIS
Tooltip options for charts.

## SYNTAX

```
New-UDChartTooltipOptions [-Disabled] [[-BackgroundColor] <DashboardColor>] [[-TitleFontFamily] <String>]
 [[-TitleFontSize] <Int32>] [[-TitleFontStyle] <String>] [[-TitleFontColor] <DashboardColor>]
 [[-TitleSpacing] <Int32>] [[-TitleMarginBottom] <Int32>] [[-BodyFontFamily] <String>]
 [[-BodyFontSize] <Int32>] [[-BodyFontStyle] <String>] [[-BodyFontColor] <DashboardColor>]
 [[-BodySpacing] <Int32>] [[-FooterFontFamily] <String>] [[-FooterFontSize] <Int32>]
 [[-FooterFontStyle] <String>] [[-FooterFontColor] <DashboardColor>] [[-FooterSpacing] <Int32>]
 [[-FooterMarginTop] <Int32>] [[-xPadding] <Int32>] [[-yPadding] <Int32>] [[-CaretPadding] <Int32>]
 [[-CaretSize] <Int32>] [[-CornerRadius] <Int32>] [[-MultiKeyBackground] <DashboardColor>]
 [[-DisplayColors] <Boolean>] [[-BorderColor] <DashboardColor>] [[-BorderWidth] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Tooltip options for charts.

## EXAMPLES

### Example 1
```
PS C:\> $TooltipOptions =  New-UDChartTooltipOptions -TitleFontSize 50
PS C:\> $Options = New-UDChartOptions -TooltipOptions $TooltipOptions
PS C:\> New-UDChart -Options $Options #...
```

Creates a new chart and sets the font size of tooltip titles to 50.

## PARAMETERS

### -BackgroundColor
Background color of the tooltip.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BodyFontColor
Body font color

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BodyFontFamily
Body font family.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BodyFontSize
Body font size.

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

### -BodyFontStyle
Body font style

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: normal, bold, italic

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BodySpacing
Spacing to add to top and bottom of each tooltip item.

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

### -BorderColor
Color of the border

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BorderWidth
Size of the border

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CaretPadding
Extra distance to move the end of the tooltip arrow away from the tooltip point.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CaretSize
Size, in px, of the tooltip arrow.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CornerRadius
Radius of tooltip corner curves.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Disabled
Disables tooltips.

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

### -DisplayColors
if true, color boxes are shown in the tooltip

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FooterFontColor
Footer font color

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FooterFontFamily
Footer font family

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FooterFontSize
Footer font size

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

### -FooterFontStyle
Footer font style

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: normal, bold, italic

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FooterMarginTop
Margin to add before drawing the footer.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FooterSpacing
```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MultiKeyBackground
Color to draw behind the colored boxes when multiple items are in the tooltip

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TitleFontColor
Title font color

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TitleFontFamily
Title font family

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TitleFontSize
Title font size.

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

### -TitleFontStyle
Title font style.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: normal, bold, italic

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TitleMarginBottom
Margin to add on bottom of title section.

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

### -TitleSpacing
Spacing to add to top and bottom of each title line.

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

### -xPadding
Padding to add on left and right of tooltip.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -yPadding
Padding to add on top and bottom of tooltip.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
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
