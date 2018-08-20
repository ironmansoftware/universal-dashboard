---
external help file: UniversalDashboard-help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# Out-UDChartData

## SYNOPSIS
Outputs data in a format that the ChartJS control understands.

## SYNTAX

```
Out-UDChartData [[-Data] <Object>] [[-DataProperty] <String>] [[-LabelProperty] <String>]
 [[-DatasetLabel] <String>] [[-Dataset] <Hashtable[]>] [[-BackgroundColor] <DashboardColor[]>]
 [[-BorderColor] <DashboardColor[]>] [[-HoverBackgroundColor] <DashboardColor[]>]
 [[-HoverBorderColor] <DashboardColor[]>] [<CommonParameters>]
```

## DESCRIPTION
Outputs data in a format that the ChartJS control understands.

## EXAMPLES

### Example 1
```
PS C:\>  New-UDChart -Type Line -Title "CPU" -Endpoint {
    Get-Process -Name chrome | Out-UDChartData -LabelProperty "Id" -DataProperty "CPU"
}
```

Outputs data from Get-Process and selects the Id as the label (x-axis) and the CPU as the data (y-axis). 

### Example 2
```
PS C:\>  New-UDChart -Type Bar -Title "Memory" -Endpoint {
    Get-Process -Name chrome | Out-UDChartData -LabelProperty "Id" -Dataset @(
        New-UDChartDataset -DataProperty "WorkingSet" -Label "Working Set" -BackgroundColor "rgb(63,123,3)"
        New-UDChartDataset -DataProperty "PeakWorkingSet" -Label "Peak Working Set" -BackgroundColor "rgb(134,342,122)"
        New-UDChartDataset -DataProperty "VirtualMemorySize" -Label "Virtual Memory Size" -BackgroundColor "rgb(234,33,43)"
    )
}
```

Outputs data from Get-Process and selects WorkingSet, PeakWorkingSet and VritualMemorySize as data sets from the output. 

## PARAMETERS

### -BackgroundColor
Background colors for the chart data.

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

### -BorderColor
Border colors for the chart data.

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

### -Data
Data to display in the chart. 

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -DataProperty
The property to select as the y-axis of the data set. This should be used in conjunction with LabelProperty.

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

### -Dataset
A collection of hashtables created by New-UDChartDataset. This allows for multiple datasets to be represented on a single chart.

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DatasetLabel
The label for a dataset.

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

### -HoverBackgroundColor
Hover background colors for the chart data.

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HoverBorderColor
Hover border colors for the chart data.

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

### -LabelProperty
The property to select as the dataset label (x-axis). This should be used in conjunction with DataProperty. 

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
