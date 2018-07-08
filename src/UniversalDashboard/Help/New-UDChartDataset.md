---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard
online version: 
schema: 2.0.0
---

# New-UDChartDataset

## SYNOPSIS
Creates a dataset for use with Out-UDChartData

## SYNTAX

```
New-UDChartDataset [[-DataProperty] <String>] [[-Label] <String>] [[-BackgroundColor] <DashboardColor[]>]
 [[-BorderColor] <DashboardColor[]>] [[-BorderWidth] <Int32>] [[-HoverBackgroundColor] <DashboardColor[]>]
 [[-HoverBorderColor] <DashboardColor[]>] [[-HoverBorderWidth] <Int32>] [[-XAxisId] <String>]
 [[-YAxisId] <String>] [[-AdditionalOptions] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
Creates a dataset for use with Out-UDChartData. This is an advanced scenario cmdlet that allows you to create multiple datasets within a single chart. 

## EXAMPLES

### Example 1
```
PS C:\>  New-UDChart -Type Bar -Title "Memory" -Endpoint {
    Get-Process -Name chrome | Out-UDChartData -LabelProperty "Id" -Dataset @(
        New-UDChartDataset -DataProperty "WorkingSet" -Label "Working Set" -BackgroundColor "rgb(63,123,3)"
        New-UDChartDataset -DataProperty "PeakWorkingSet" -Label "Peak Working Set" -BackgroundColor "rgb(134,342,122)"
        New-UDChartDataset -DataProperty "VirtualMemorySize" -Label "Virtual Memory Size" -BackgroundColor "rgb(234,33,43)"
    )
}
```

Creates a chart with different datasets of different types of memory usage.

## PARAMETERS

### -AdditionalOptions
Additional options to pass to the dataset. This value can be different depending on the type of chart specified. See the ChartJS documentation for more information. http://www.chartjs.org/docs/latest/charts/line.html

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: 

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BackgroundColor
The background color of the dataset in the chart. Should be in rgba() syntax.

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BorderColor
The border color of the dataset in the chart. Should be in rgba() syntax.

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BorderWidth
The width of the border in pixels.

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

### -DataProperty
The property to select as the data for the y value of the chart. 

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
The hover background color of the dataset in the chart. Should be in rgba() syntax.

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

### -HoverBorderColor
The hover border color of the dataset in the chart. Should be in rgba() syntax.

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HoverBorderWidth
The hover width of the border in pixels.

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

### -Label
A label of this dataset. 

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

### -XAxisId
The ID of the X axis. Used for advanced properties.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -YAxisId
The ID of the Y axis. Used for advanced properties.

```yaml
Type: String
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

