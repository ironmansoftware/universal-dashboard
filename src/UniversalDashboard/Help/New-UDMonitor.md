---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDMonitor

## SYNOPSIS
Creates a live updating chart that shows a single type of data on a running time scale.

## SYNTAX

```
New-UDMonitor [-Type <ChartType>] -Title <String> [-DataPointHistory <Int32>] [-Options <Hashtable>]
 [-ChartBackgroundColor <DashboardColor[]>] [-ChartBorderColor <DashboardColor[]>]
 [-BackgroundColor <DashboardColor>] [-Width <String>] [-Height <String>] [-FontColor <DashboardColor>]
 [-BorderWidth <Int32>] [-Label <String[]>] [-Links <Link[]>] [-FilterFields <ScriptBlock>]
 [-Endpoint <ScriptBlock>] [-ArgumentList <Object[]>] [-AutoRefresh] [-RefreshInterval <Int32>] [-Id <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a live updating chart that shows a single type of data.  This is paired with Out-UDMonitorData to output data on a running time scale.

## EXAMPLES

### Example 1
```
PS C:\>  New-UDMonitor -Type Line -Title "CPU" -RefreshInterval 1 -DataPointHistory 100 -Endpoint {
    Get-Counter '\Memory\Available MBytes' | Select-Object -ExpandProperty CounterSamples | Select -ExpandProperty CookedValue | Out-UDMonitorData
}
```

Displays available memory in megabytes for the machine. 

## PARAMETERS

### -ArgumentList
Arguments to pass to the endpoint. They will be available via the $ArgumentList variable.

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
Whether to auto refresh this component. This is on by default for this control. 

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
The background color of the component containing the chart.

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

### -BorderWidth
The border width for the chart.

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

### -ChartBackgroundColor
Background fill color of the chart.

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChartBorderColor
Order color of the chart. 

```yaml
Type: DashboardColor[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DataPointHistory
The number of data points to keep in the history.

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

### -Endpoint
The endpoint definition for this chart. The endpoint should return a single data value via the Out-UDMonitorData cmdlet. 

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
Font color

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

### -Height
Set monitor custom height, you can use px,vw,%
You can NOT use this parameter without width parameter.
If you do you will get an error.

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

### -Id
The HTML ID and endpoint ID for this component.

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

### -Label
A list of labels to use when defining multiple datasets. If this isn't specified, the Title is used.

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
Links to display on the bottom of the monitor. Use New-UDLink to generate a link.

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
The refresh interval for this control. This defaults to 5 seconds. 

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
The title of this chart. 

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
The type of chart to use. 

```yaml
Type: ChartType
Parameter Sets: (All)
Aliases:
Accepted values: Bar, Line, Area, Doughnut, Radar, Pie, HorizontalBar

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Width
Set monitor custom width, you can use px,vw,%
You can use only width without the height parameter.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
