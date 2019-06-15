---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: 
schema: 2.0.0
---

# New-UDGrid

## SYNOPSIS
Creates a grid in the dashboard.

## SYNTAX

```
New-UDGrid [-Title <String>] -Headers <String[]> -Properties <String[]> [-DefaultSortColumn <String>]
 [-DefaultSortDescending] [-BackgroundColor <DashboardColor>] [-FontColor <DashboardColor>] [-Links <Link[]>]
 [-ServerSideProcessing] [-DateTimeFormat <String>] [-PageSize <Int32>] [-NoPaging] [-FilterText <String>]
 [-Endpoint <ScriptBlock>] [-ArgumentList <Object[]>] [-AutoRefresh] [-RefreshInterval <Int32>] [-Id <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a grid in the dashboard with data supplied by a PowerShell endpoint. The grid is produced using jQuery DataTables. 

## EXAMPLES

### Example 1
```
PS C:\> New-UDGrid -Title "Process Information" -Headers @("Name", "Process Id", "Start Time", "Responding") -Properties @("Name", "Id", "StartTime", "Responding")  -Endpoint {
            Get-Process -Name Chrome | Out-UDGridData
        }
```

Creates a grid in the dashboard that displays the process information for Chrome running on the machine.

### Example 2
```
PS C:\> New-UDGrid -Title "Service Information" -Headers @("Status", "Name", "Display Name") -Properties @("Status", "Name", "DisplayName")  -Endpoint {
            Get-Service | Out-UDGridData
        }
```

Creates a grid in the dashboard that displays the service information on the machine.

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
Enables auto refresh for this control.

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
The background color of the grid.

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

### -DateTimeFormat
The DateTime format to use in the Grid. This is a MomentJS DateTime format.

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

### -DefaultSortColumn
Specifies the column index of the default sort column. This index begins with zero.  

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

### -DefaultSortDescending
Specifies whether to sort descending or ascending by default. 

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

### -Endpoint
The endpoint that returns the grid data.

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

### -FilterText
Text to override the "Filter" placeholder text.

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

### -FontColor
The font color of the grid.

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

### -Headers
The headers to use for the grid columns. The count of headers should match the count of properties.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The id of the grid. This is the HTML markup ID.

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

### -Links
Links to display on the bottom of the grid. Use New-UDLink to generate a link.

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

### -NoPaging
Disables paging for this grid.

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

### -PageSize
The number of items to display per page.

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

### -Properties
The properties to select from objects for data in the row. The number of properties should match the number of headers.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RefreshInterval
The number of seconds between refreshes. The default is 5.

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

### -ServerSideProcessing
Turns on server side processing for the grid. This disables client-side filtering, sort and paging. 

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

### -Title
The title of the section for this grid.

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

