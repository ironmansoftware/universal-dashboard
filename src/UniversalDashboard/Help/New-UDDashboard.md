---
external help file: UniversalDashboard.dll-Help.xml
Module Name: UniversalDashboard.Community
online version:
schema: 2.0.0
---

# New-UDDashboard

## SYNOPSIS
Creates a new dashboard. The result of this cmdlet should be passed to Start-UDDashboard.

## SYNTAX

### Content
```
New-UDDashboard [-Title <String>] -Content <ScriptBlock> [-NavBarColor <DashboardColor>]
 [-NavBarFontColor <DashboardColor>] [-BackgroundColor <DashboardColor>] [-FontColor <DashboardColor>]
 [-NavbarLinks <Link[]>] [-Scripts <String[]>] [-Stylesheets <String[]>] [-CyclePages]
 [-CyclePagesInterval <Int32>] [-Footer <Footer>] [-NavBarLogo <Element>]
 [-EndpointInitialization <InitialSessionState>] [-Theme <Theme>] [-GeoLocation] [<CommonParameters>]
```

### Pages
```
New-UDDashboard [-Title <String>] -Pages <Page[]> [-NavBarColor <DashboardColor>]
 [-NavBarFontColor <DashboardColor>] [-BackgroundColor <DashboardColor>] [-FontColor <DashboardColor>]
 [-NavbarLinks <Link[]>] [-Scripts <String[]>] [-Stylesheets <String[]>] [-CyclePages]
 [-CyclePagesInterval <Int32>] [-Footer <Footer>] [-NavBarLogo <Element>]
 [-EndpointInitialization <InitialSessionState>] [-Theme <Theme>] [-GeoLocation] [<CommonParameters>]
```

## DESCRIPTION
Creates a new dashboard. The result of this cmdlet should be passed to Start-UDDashboard.

## EXAMPLES

### Example 1
```
PS C:\> $Dashboard = New-UDDashboard -Color "blue" -Content {
	New-UDChart ...
}
```

Creates a new dashboard with a blue color that contains a chart. 

### Example 2
```
PS C:\> Start-UDDashboard -Dashboard {
	New-UDDashboard -Color "blue" -Content {
		New-UDChart ...
	}
}
```

Creates a new dashboard with a blue color that contains a chart and starts it.

### Example 3
```
PS C:\> $Page1 = New-UDPage -Name "Home" -Content { New-Chart... }
PS C:\> $Page2 = New-UDPage -Name "Cards" -Content { New-Card... }

PS C:\> $Dashboard = New-UDDashboard -Color "blue" -Pages @($Page1, $Page2)
```

Creates a multi-page dashboard. The will show a navigation pane on the left side of the dashboard to navigate to different pages.

## PARAMETERS

### -BackgroundColor
Background color.

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

### -Content
Content of the dashboard. 

```yaml
Type: ScriptBlock
Parameter Sets: Content
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CyclePages
Changes pages in the dashboard automatically.

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

### -CyclePagesInterval
The number of seconds to wait on each page before changing to the next page. Defaults to 10 seconds.

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

### -EndpointInitialization
{{Fill EndpointInitialization Description}}

```yaml
Type: InitialSessionState
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FontColor
Font color.

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

### -Footer
Configuration options for the footer. Use New-UDFooter to create the object for these options.

```yaml
Type: Footer
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GeoLocation
Enables GeoLocation support for the dashboard. A $Location variable will be defined in all endpoints
when this is enabled. When a user allows the dashboard to get their location, you will have access to the
latitude, longitude, heading and speed. 

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

### -NavBarColor
Navigation bar and footer color.

```yaml
Type: DashboardColor
Parameter Sets: (All)
Aliases: Color

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NavBarFontColor
Navigation bar and footer font color. 

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

### -NavBarLogo
A logo to use within the navbar. Use New-UDImage to create this logo.

```yaml
Type: Element
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NavbarLinks
Links to present on the dashboard. Use New-UDLink to create links.

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

### -Pages
An array of pages to display in a multi-page dashboard.

```yaml
Type: Page[]
Parameter Sets: Pages
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scripts
Additional scripts to include with the dashboard. These scripts are not copied but just referenced in the output HTML.

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

### -Stylesheets
Additional stylesheets to include with the dashboard. These stylesheets are not copied but just referenced in the output HTML.

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

### -Theme
The theme to use with this dashboard. This can be a predefined theme supplied by Get-UDTheme or a custom theme created with New-UDTheme.

```yaml
Type: Theme
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Title for the dashboard.

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
