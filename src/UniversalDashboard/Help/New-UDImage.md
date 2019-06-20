---
external help file: UniversalDashboard.Community-help.xml
Module Name: UniversalDashboard.Community
online version: https://github.com/ironmansoftware/universal-dashboard/blob/master/src/UniversalDashboard/Help/New-UDImage.md
schema: 2.0.0
---

# New-UDImage

## SYNOPSIS
Renders an image in the dashboard.

## SYNTAX

### url (Default)
```
New-UDImage [-Id <String>] [-Url <String>] [-Height <Int32>] [-Width <Int32>] [-Attributes <Hashtable>]
 [<CommonParameters>]
```

### path
```
New-UDImage [-Id <String>] [-Path <String>] [-Height <Int32>] [-Width <Int32>] [-Attributes <Hashtable>]
 [<CommonParameters>]
```

## DESCRIPTION
Renders an image in the dashboard.

## EXAMPLES

### Example 1
```
New-UDImage -Url "https://i1.wp.com/ironmansoftware.com/wp-content/uploads/2019/01/dsl.png" -Height 50 -Width 50
```

Inserts the Google logo and sizes it to 50px by 50px.

### Example 2
```
New-UDImage -Height 125 -Width 125 -Url "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTYwIiBoZWlnaHQ9IjE2MCIgdmlld0JveD0iMCAwIDE2MCAxNjAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHRpdGxlPkFydGJvYXJkIDY8L3RpdGxlPjxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PHBhdGggZD0iTTE0NC4wODYgODAuNTY4Yy0yMS45NzguNDMtMTcuNDAyIDE0LjM0Ni0zMi44OSAxNy44NjZDOTUuNDYgMTAyLjAxIDkyLjk3NSA2MCA3Ny4yNDMgNjBjLTE1LjczMyAwLTE5LjIxNiA0MC44MDYtMzguOTE4IDY4LjgyM2wtLjU2Ljc5NEw4MCAxNTRsNjQuMDg2LTM3VjgwLjU2OHoiIGZpbGw9IiMzNkEyRUIiLz48cGF0aCBkPSJNMTQ0LjA4NiA3OS4zQzEzNi43MjYgNjkuODU2IDEzMS43MzYgNTkgMTIxIDU5Yy0xOSAwLTE0IDMxLTM1IDMxcy0yMy4yMDctMzMuMzQ2LTQ3LTJjLTcuNTggOS45ODgtMTMuNjgyIDIxLjEyNC0xOC40NzUgMzEuNjYyTDgwIDE1NGw2NC4wODYtMzdWNzkuM3oiIGZpbGw9IiNGRkNFNTYiLz48cGF0aCBkPSJNMTUuOTE0IDkyLjE0M0MyMy4xMjQgNzIuMTczIDI2LjIzNyA1NiA0MCA1NmMyMSAwIDI2IDU5IDQ0IDUzczE2LTM4IDQ0LTM4YzUuMzMgMCAxMC43NzIgMy4yNjMgMTYuMDg2IDguNTQ2VjExN0w4MCAxNTRsLTY0LjA4Ni0zN1Y5Mi4xNDN6IiBmaWxsLW9wYWNpdHk9Ii44IiBmaWxsPSIjRkU2MTg0Ii8+PHBhdGggc3Ryb2tlPSIjRTdFOUVEIiBzdHJva2Utd2lkdGg9IjgiIGQ9Ik04MCA2bDY0LjA4NiAzN3Y3NEw4MCAxNTRsLTY0LjA4Ni0zN1Y0M3oiLz48L2c+PC9zdmc+"
```

Inserts an SVG, base64 logo and sizes it to 50px by 50px.

## PARAMETERS

### -Attributes
{{Fill Attributes Description}}

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

### -Height
The height in pixels.

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

### -Id
The ID of the image.

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

### -Path
The Path of the icon on the local file system. 

```yaml
Type: String
Parameter Sets: path
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Url
The URL of the image. This can be a base64 encoded data string.

```yaml
Type: String
Parameter Sets: url
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Width
The width in pixels.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

