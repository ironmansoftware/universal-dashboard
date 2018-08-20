---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDChart

## SYNOPSIS
Creates a new chart.

## SYNTAX

```
New-UDChart [-Labels <String[]>] [-Type <ChartType>] [-Title <String>] [-Options <Hashtable>]
 [-BackgroundColor <DashboardColor>] [-FontColor <DashboardColor>] [-Links <Link[]>]
 [-FilterFields <ScriptBlock>] [-Endpoint <ScriptBlock>] [-ArgumentList <Object[]>] [-AutoRefresh]
 [-RefreshInterval <Int32>] [-Id <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a new chart on the dashboard. Chart data is provided via a PowerShell endpoint. This cmdlet is paired with Out-UDChartData and New-UDChartDataset to
provide the data for display to the chart. 

## EXAMPLES

### Example 1
```
PS C:\> New-UDChart -Type Bar -Memory "CPU" -Endpoint {
	Get-Process -Name chrome | Out-UDChartData -LabelProperty "Id" -DataProperty "CPU"
}
```

Creates a simple bar chart with information about the CPU usage of all the chrome processes running on the current machine. 

### Example 2
```
PS C:\> New-UDChart -Type Bar -Memory "CPU" -Endpoint {
			Get-Process -Name chrome | Out-UDChartData -LabelProperty "Id" -Dataset @(
				New-UDChartDataset -DataProperty "WorkingSet" -Label "Working Set" -BackgroundColor "rgb(63,123,3)"
				New-UDChartDataset -DataProperty "PeakWorkingSet" -Label "Peak Working Set" -BackgroundColor "rgb(134,342,122)"
				New-UDChartDataset -DataProperty "VirtualMemorySize" -Label "Virtual Memory Size" -BackgroundColor "rgb(234,33,43)"
			)
}
```

Creates a bar chart with multiple data sets displaying different types of memory usage. Each data set is colored and labeled differently. 

## PARAMETERS

### -ArgumentList
Arguments to pass to to the endpoint.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoRefresh
Enables auto refresh for this component.

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

### -BackgroundColor
Background color of the chart control.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Endpoint
The endpoint that is called on the server to get data for the chart. Use Out-UDChartData and optionally, New-UDChartDataset to format data 
to return correctly from the endpoint. 

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilterFields
Input controls to adjust chart data. Use New-UDInputField to create fields for this script block.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontColor
Font color of the chart control.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The ID of the chart. This ID is set on the HTML markup and is also used to identify the endpoint. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Labels
Specifies labels to be used for the chart data. This is used instead of the LabelProperty of New-UDChartData.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Links
Links to display on the bottom of the chart. Use New-UDLink to generate a link.

```yaml
Type: Link[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Options
ChartJS options to pass. This is a hashtable of options and should match the format of ChartJS options. See http://www.chartjs.org/docs/latest/ for more information.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RefreshInterval
The number of seconds between auto refreshes. This defauts to 5 seconds. 

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
The title of the section containing the chart. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
The type of chart to display.

```yaml
Type: ChartType
Parameter Sets: (All)
Aliases:
Accepted values: Bar, Line, Area, Doughnut, Radar, Pie

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
