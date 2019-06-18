---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# New-UDLineChartDataset

## SYNOPSIS
Creates a dataset for a line chart.

## SYNTAX

```
New-UDLineChartDataset [[-DataProperty] <String>] [[-Label] <String>] [[-xAxisId] <String>]
 [[-yAxisId] <String>] [[-BackgroundColor] <DashboardColor[]>] [[-BorderColor] <DashboardColor[]>]
 [[-BorderWidth] <Int32>] [[-BorderCapStyle] <String>] [[-BorderJoinStyle] <String>] [[-Fill] <Object>]
 [[-LineTension] <Int32>] [[-PointBackgroundColor] <DashboardColor[]>] [[-PointBorderColor] <DashboardColor[]>]
 [[-PointBorderWidth] <Int32[]>] [[-PointRadius] <Int32[]>] [[-PointStyle] <String[]>]
 [[-PointHitRadius] <Int32[]>] [[-PointHoverBackgroundColor] <DashboardColor[]>]
 [[-PointHoverBorderColor] <DashboardColor[]>] [[-PointHoverBorderWidth] <Int32[]>]
 [[-PointHoverRadius] <Int32[]>] [[-ShowLine] <Boolean>] [[-SpanGaps] <Boolean>] [[-SteppedLine] <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION
The line chart allows a number of properties to be specified for each dataset. These are used to set display properties for a specific dataset. For example, the colour of a line is generally set this way.

## EXAMPLES

## PARAMETERS

### -BackgroundColor
The fill color under the line. 

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BorderCapStyle
Cap style of the line.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: butt, round, square

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BorderColor
The color of the line.

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BorderJoinStyle
Line joint style. 

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: bevel, round, miter

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BorderWidth
The width of the line in pixels.

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

### -DataProperty
The property of the object to use as the y-Axis of the dataset.

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

### -Fill
How to fill the area under the line.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Label
The label for the dataset which appears in the legend and tooltips.

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

### -LineTension
Bezier curve tension of the line. Set to 0 to draw straightlines. This option is ignored if monotone cubic interpolation is used.

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

### -PointBackgroundColor
The fill color for points.

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PointBorderColor
The border color for points.

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PointBorderWidth
The width of the point border in pixels.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PointHitRadius
The pixel size of the non-displayed point that reacts to mouse events.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PointHoverBackgroundColor
Point background color when hovered.

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PointHoverBorderColor
Point border color when hovered.

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PointHoverBorderWidth
Border width of point when hovered.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PointHoverRadius
Radius of the point when hovered.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PointRadius
The radius of the point.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PointStyle
Style of the point. 

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 
Accepted values: circle, cross, crossRot, dash, line, rect, rectRounded, rectRot, star, triangle

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowLine
If false, the line is not drawn for this dataset.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SpanGaps
If true, lines will be drawn between points with no or null data. If false, points with NaN data will create a break in the line

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SteppedLine
If the line is shown as a stepped line.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: 

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -xAxisId
The ID of the x axis to plot this dataset on. If not specified, this defaults to the ID of the first found x axis.

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

### -yAxisId
The ID of the y axis to plot this dataset on. If not specified, this defaults to the ID of the first found y axis.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

