---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# New-UDBarChartDataset

## SYNOPSIS
Creates a dataset with specific options for bar charts.

## SYNTAX

```
New-UDBarChartDataset [[-DataProperty] <String>] [[-Label] <String>] [[-xAxisId] <String>]
 [[-yAxisId] <String>] [[-BackgroundColor] <DashboardColor[]>] [[-BorderColor] <DashboardColor[]>]
 [[-BorderWidth] <Int32>] [[-BorderSkipped] <String>] [[-HoverBackgroundColor] <DashboardColor[]>]
 [[-HoverBorderColor] <DashboardColor[]>] [[-HoverBorderWidth] <Int32[]>] [<CommonParameters>]
```

## DESCRIPTION
Creates a dataset with specific options for bar charts. Use with Out-UDChartData.

## EXAMPLES

### Example 1
```
PS C:\> New-UDBarChartDataset -DataProperty "Jpg" -Label "Jpg" -BackgroundColor "#80962F23"
```

Creates a new bar chart data set for the JPG property and sets a background color.

## PARAMETERS

### -BackgroundColor
The fill color of the bar. 

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

### -BorderColor
The color of the bar border. 

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

### -BorderSkipped
Which edge to skip drawing the border for.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: bottom, left, top, right

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BorderWidth
The stroke width of the bar in pixels.

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

### -HoverBackgroundColor
The fill colour of the bars when hovered.

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HoverBorderColor
The stroke colour of the bars when hovered.

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HoverBorderWidth
The stroke width of the bars when hovered.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 10
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

### -xAxisId
The ID of the x axis to plot this dataset on. If not specified, this defaults to the ID of the first found x axis

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

